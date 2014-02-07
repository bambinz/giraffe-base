class UsersController < ApplicationController
  
  filter_resource_access

  # GET /users/
  # GET /users/
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @is_remote = true
    @friends = current_user.friends
    @user_settings = nil
    @sent_requests = KeyRequest.sent_friend_requests_for_user(current_user)
    @received_requests = KeyRequest.received_friend_requests_for_user(current_user)
    @setting = @user.setting

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @is_remote = false
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.roles << Role.find_by_name(:user)
    @user.build_setting
    @user.setting.set_defaults

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'Registration successful.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Successfully updated profile.' }
        format.js { render layout: false }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.delete
    
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def list_friends
    @friends = current_user.friends
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_friends }
    end
  end

  def show_friend
    @friend = User.find(params[:friend_id])
    if !current_user.can_see_users_profile?(@friend)
      redirect_to root_url, flash: { error: "You are not friends with this user and their profile is not public." }
      return false
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friend }
    end
  end
  
  def search_users_window
    respond_to do |format|
      format.js { render layout: false }
    end
  end
  
  def search_users
    @users = User.where('username like ?', params[:search]).joins(:setting).where("settings.show_in_search is 't'")
    
    respond_to do |format|
      format.js { render layout: false }
    end
  end

end
