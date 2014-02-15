class UserFriend < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"
  
  def self.add_friend(user_id, friend_id)
    user_friend = UserFriend.new
    user_friend.user_id = user_id
    user_friend.friend_id = friend_id
    user_result = user_friend.save
    
    user_friend = UserFriend.new
    user_friend.user_id = friend_id
    user_friend.friend_id = user_id
    friend_result = user_friend.save
    
    user_result && friend_result
  end
  
  def self.remove_friend(user_id, friend_id)
    user_friend = UserFriend.where(user_id: user_id, friend_id: friend_id).first
    if !user_friend
      user_friend = UserFriend.where(user_id: friend_id, friend_id: user_id).first
    end
    
    if user_friend
      user_friend.destroy
    end

    key_request = KeyRequest.where(user_id: user_id, to_user_id: friend_id).first
    if !key_request
      key_request = KeyRequest.where(user_id: friend_id, to_user_id: user_id).first
    end
    
    if key_request
      key_request.destroy
    end
  end
end
