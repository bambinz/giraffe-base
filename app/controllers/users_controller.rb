class UsersController < ApplicationController

  filter_resource_access

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    if @user != current_user
      if !current_user.can_see_users_profile?(@user)
        redirect_to root_url, flash: { error: "You are not friends with this user and their profile is not public." }
        return false
      else
        render 'show_public'
        return true
      end
    else
      @is_remote = true
      @friends = current_user.friends
      @user_settings = nil
      @sent_requests = KeyRequest.sent_friend_requests_for_user(current_user)
      @received_requests = KeyRequest.received_friend_requests_for_user(current_user)
      @setting = @user.setting
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    @is_remote = false
  end

  def create
    @user = User.new(params[:user])
    @user.roles << Role.find_by_name(:user)
    @user.build_setting
    @user.setting.set_defaults

    if @user.save
      redirect_to root_url, notice: 'Registration successful.'
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Successfully updated profile.' }
        format.js { render layout: false }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.delete

    redirect_to users_url
  end

  def list_friends
    @friends = current_user.friends
  end

  def search_users_window
    render layout: false
  end

  def search_users
    @users = []
    if params[:search] && params[:search] != "" && params[:search].gsub(" ", "") != ""
      @users = User.where('username ILIKE ?', "%#{params[:search]}%").joins(:setting).where("settings.show_in_search" => true)
    end

    render layout: false
  end

end
