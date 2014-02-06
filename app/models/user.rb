class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :email, :password, :username, :password_confirmation
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :key_requests
  
  has_many :user_friends
  has_many :friends, through: :user_friends, class_name: "User", source: :friend
  
  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end

  def has_friend_request_with?(friend)
    (KeyRequest.where(user_id: id, to_user_id: friend.id).count != 0) || (KeyRequest.where(user_id: friend.id, to_user_id: id).count != 0)
  end
end
