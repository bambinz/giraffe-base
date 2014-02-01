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
    @friends = []
    @user_settings = nil

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

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Registration successful.' }
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
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_friend }
    end
  end
  
  def search_users_window
    respond_to do |format|
      format.js { render layout: false }
    end
  end
  
  def search_users
    @users = User.where('username like ?', params[:search])
    
    respond_to do |format|
      format.js { render layout: false }
    end
  end

end
