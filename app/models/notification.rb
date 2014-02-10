class Notification < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :content, :notification_type, :priority, :seen, :read

  module NotificationTypes
    RECEIVED_FRIEND_REQUEST = 0
    ACCEPT_FRIEND_REQUEST = 1
  end

  module NotificationPriorities
    LOW = 0
    MEDIUM = 1
    HIGH = 2
  end

  NOTIFICATION_TYPES = { 0 => "Received Friend Request", 1 => "Accepted Fried Request" }
  NOTIFICATION_PRIORITIES = { 0 => "Low", 1 => "Medium", 2 => "High" }

  def self.notifications_for_user(current_user)
    Notification.where(user_id: current_user.id).order('created_at DESC')
  end

  def self.num_unseen_notifications_for_user(current_user)
    if current_user
      Notification.where(user_id: current_user.id, seen: false).order('created_at DESC').count
    end
  end

  def self.num_unread_notifications_for_user(current_user)
    if current_user
      Notification.where(user_id: current_user.id, read: false).order('created_at DESC').count
    end
  end

  def self.unread_notifications_for_user(current_user)
    if current_user
      res = Notification.where(user_id: current_user.id, read: false).order('created_at DESC')
      res
    end
  end

  def self.create_notification(user_id, content, type, priority)
    notification = Notification.new
    notification.user_id = user_id
    notification.content = content
    notification.notification_type = type
    notification.priority = priority
    notification.seen = false
    notification.read = false
    notification.save
  end

  def self.users_to_notify(current_user, project, include_admin)
    user_ids = []

    #fill user_ids

    if include_admin
      admin_user_ids = User.joins(:roles).where('roles.name' => 'Admin').pluck(:id)
      user_ids.concat(admin_user_ids)
    end
    user_ids.uniq!
    user_ids = user_ids - [current_user.id]
  end

  def title
    if !notification_type
      puts 'SOMETHING WENT WRONG'
      return ""
    end
    
    NOTIFICATION_TYPES[notification_type]
  end
  
  def self.received_friend_request_notification(for_user, from_user)
    content = "You have received a friend request from #{from_user.username}."
    create_notification(for_user.id, content, NotificationTypes::RECEIVED_FRIEND_REQUEST, NotificationPriorities::LOW)
  end
  
  def self.accepted_friend_request_notification(for_user, from_user)
    content = "#{from_user.username} has accepted your friend request."
    create_notification(for_user.id, content, NotificationTypes::ACCEPT_FRIEND_REQUEST, NotificationPriorities::LOW)
  end


end
