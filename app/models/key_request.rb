class KeyRequest < ActiveRecord::Base
  belongs_to :user
  attr_accessible :expire_date, :key, :accepted, :accepted_date, :key_request_type, :to_user_id, :ignored
  validates_presence_of :expire_date, :key, :key_request_type, :to_user_id

  module KeyRequestType
    FRIEND_REQUEST = 0
    EMAIL_VERIFICATION = 1
  end

  module RequestResult
    SUCCESS = 0
    ERROR = 1
    REQUEST_EXPIRED = 2
    REQUEST_ALREADY_USED = 3
  end

  def generate_key
    begin
      self.key = SecureRandom.hex
    end while self.class.exists?(key: key)
  end

  def self.generate_friend_request(user, friend)
    if !user.has_friend_request_with?(friend)
      kr = KeyRequest.new
      kr.user_id = user.id
      kr.to_user_id = friend.id
      kr.key_request_type = KeyRequestType::FRIEND_REQUEST
      kr.expire_date = Date.current + 30.days
      kr.accepted = false
      kr.generate_key
      kr.ignored = false
      kr.save
      
      Notification.received_friend_request_notification(friend, user)
      
      kr
    else
      return nil
    end
  end

  def accept_friend_request
    if expire_date < Date.current
      return { error: RequestResult::REQUEST_EXPIRED }
    end

    if accepted
      return { error: RequestResult::REQUEST_ALREADY_USED }
    end

    if UserFriend.add_friend(user_id, to_user_id)
      self.accepted_date = Date.current
      self.accepted = true
      
      user_1 = User.find(user_id)
      user_2 = User.find(to_user_id)
      
      Notification.accepted_friend_request_notification(user_1, user_2)
      
      Badge.add_friend_badge(user_1)
      current_users_badge = Badge.add_friend_badge(user_2)
      
      if self.save!
        return { result: true, badge: current_users_badge }
      end
      
    else
      return error { RequestResult::ERROR }
    end
  end

  def remove_friend_request
    self.destroy
  end
  
  def ignore_friend_request
    self.ignored = true
    self.save
  end

  def self.sent_friend_requests_for_user(user)
    KeyRequest.where(key_request_type: KeyRequest::KeyRequestType::FRIEND_REQUEST, user_id: user.id, accepted: false)
  end
  
  def self.received_friend_requests_for_user(user)
    KeyRequest.where(key_request_type: KeyRequest::KeyRequestType::FRIEND_REQUEST, to_user_id: user.id, accepted: false, ignored: [false, nil])
  end

end
