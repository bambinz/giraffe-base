class KeyRequestsController < ApplicationController
  
  filter_access_to :all, except: [:send_friend_request]
  
  def list_friend_requests
    @key_requests = KeyRequest.list_friend_requests_for_user(current_user)
    
    respond_to do |format|
      format.html
      format.json { render json: @user_friend }
    end
  end
  
  def send_friend_request
    @request = KeyRequest.generate_friend_request(current_user, User.find(params[:friend_id]))
    
    respond_to do |format|
      format.js { render layout: false }
      format.json { render json: @user_friend }
    end
  end
  
  def accept_friend_request
    @key_request = KeyRequest.find(params[:key_request_id])
    @key_request.accept_friend_request
    
    respond_to do |format|
      format.html
      format.json { render json: @user_friend }
    end
  end
end
