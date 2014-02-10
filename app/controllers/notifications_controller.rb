class NotificationsController < ApplicationController
  
  filter_access_to :all, :except => [:mark_all_as_read]
  
  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.notifications_for_user(@current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifications }
    end
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # PUT /notifications/1
  # PUT /notifications/1.json
  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def mark_as_seen
    @notification = Notification.find(params[:id])
    @notification.seen = true
    @notification.save

    respond_to do |format|
      format.js { render layout: false, locals: { klass: params[:klass], seen: @notification.seen }}
      format.json { render json: @notification }
    end
  end
  
  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.seen = true
    @notification.read = true
    @notification.save
    @notifications_count = Notification.unread_notifications_for_user(current_user).count
    
    @js_action = params[:js_action]

    respond_to do |format|
      format.js { render layout: false, locals: { klass: params[:klass], seen: (@notification.read == true ? "Yes" : "No") }}
      format.json { render json: @notification }
    end
  end
  
  def mark_all_as_read
    Notification.all.each do |notification|
      notification.seen = true
      notification.read = true
      notification.save
    end
    
    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.json { render json: @notifications }
    end
  end

end
