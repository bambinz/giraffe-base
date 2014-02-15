class User < ActiveRecord::Base
  acts_as_authentic
  extend FriendlyId
  friendly_id :username
  validates_format_of :username, :with => /^[A-Za-zd_]+$/
  attr_accessible :email, :password, :username, :password_confirmation, :first_name, :last_name, :caption, :about_me, :points
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :key_requests
  has_many :user_friends
  has_many :friends, through: :user_friends, class_name: "User", source: :friend
  has_one :setting
  has_many :user_badges
  has_many :badges, through: :user_badges
  
  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end

  def has_friend_request_with?(friend)
    (KeyRequest.where(user_id: id, to_user_id: friend.id).count != 0) || (KeyRequest.where(user_id: friend.id, to_user_id: id).count != 0)
  end
  
  def is_friends_with(user)
    friends.include?(user)
  end
  
  def can_send_friend_request_to_user(user)
    if self == user
      return false
    elsif self.is_friends_with(user)
      return false
    elsif !user.setting.accept_friend_reqests
      return false
    else
      return true
    end
  end
  
  def can_see_users_profile?(user)
    if !is_friends_with(user) && !user.setting.public_profile
      return false
    end
    return true
  end
  
  def has_complete_profile
    complete = self.email != nil && self.email != ""
    complete = complete && self.first_name != nil && self.first_name != ""
    complete = complete && self.last_name != nil && self.last_name != ""
    complete = complete && self.caption != nil && self.caption != ""
    complete = complete && self.about_me != nil && self.about_me != ""
  end
  
end
