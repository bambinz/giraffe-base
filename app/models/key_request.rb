class KeyRequest < ActiveRecord::Base
  belongs_to :user
  attr_accessible :expire_date, :key, :accepted, :accepted_date, :key_request_type, :to_user_id
  validates_presence_of :expire_date, :key, :accepted, :key_request_type, :to_user_id
  
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
    kr = KeyRequest.new
    kr.user_id = user.id
    kr.to_user_id = friend.id
    kr.key_request_type = KeyRequestType::FRIEND_REQUEST
    kr.expire_data = Date.current + 30.days
    kr.accepted = false
    kr.generate_key
    kr.save
  end
  
  def accept_friend_request
    if expire_date < Date.current
      return RequestResult::REQUEST_EXPIRED
    end
    
    if accepted
      return RequestResult::REQUEST_ALREADY_USED
    end
    
    if UserFriend.add_friend(user_id, to_user_id)
      self.accepted_date = Date.current
      self.accepted = true
      self.save
    else
      return RequestResult::ERROR
    end
  end
  
  def reject_friend_request
    self.delete!
  end
  
end
