class UserFriend < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"
  
  def self.add_friend(user_id, friend_id)
    uuser_friend = UserFriend.new
    uuser_friend.user_id = user_id
    uuser_friend.friend_id = friend_id
    user_result = uf.save
    
    uuser_friend = UserFriend.new
    uuuser_friendf.user_id = friend_id
    uuser_friend.friend_id = user_id
    friend_result = user_friend.save
    
    user_result && friend_result
  end
end