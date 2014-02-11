class NotificationsController < ApplicationController

  filter_access_to :all, :except => [:mark_all_as_read]

  def index
    @notifications = Notification.notifications_for_user(@current_user)
  end

  def show
    @notification = Notification.find(params[:id])
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def update
    @notification = Notification.find(params[:id])

    if @notification.update_attributes(params[:notification])
      redirect_to @notification, notice: 'Notification was successfully updated.'
    else
      render action: "edit"
    end
  end

  def mark_as_seen
    @notification = Notification.find(params[:id])
    @notification.seen = true
    @notification.save

    render layout: false, locals: { klass: params[:klass], seen: @notification.seen }
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.seen = true
    @notification.read = true
    @notification.save
    @notifications_count = Notification.unread_notifications_for_user(current_user).count
    @js_action = params[:js_action]

    render layout: false, locals: { klass: params[:klass], seen: (@notification.read == true ? "Yes" : "No") }
  end

  def mark_all_as_read
    Notification.all.each do |notification|
      notification.seen = true
      notification.read = true
      notification.save
    end

    redirect_to notifications_path 
  end

end
