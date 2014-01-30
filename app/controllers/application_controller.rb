class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :num_new_notifications, :unseen_notifications
  before_filter { |c| Authorization.current_user = c.current_user }
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.record
  end
  
  def permission_denied
    flash[:error] = "Sorry, you not allowed to access that page."
    redirect_to root_url
  end
  
  def num_new_notifications
    @num_new_notifications = Notification.num_unseen_notifications_for_user(@current_user)
  end
  
  def unseen_notifications
    Notification.unread_notifications_for_user(@current_user)
  end
  
end
