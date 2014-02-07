class KeyRequestsController < ApplicationController
  
  filter_access_to :all, except: [:send_friend_request]
  
  def list_friend_requests
    @key_requests = KeyRequest.list_friend_requests_for_user(current_user)
    
    respond_to do |format|
      format.html
      format.json { render json: @key_requests }
    end
  end
  
  def send_friend_request
    @request = KeyRequest.generate_friend_request(current_user, User.find(params[:friend_id]))
    
    respond_to do |format|
      format.js { render layout: false }
      format.json { render json: @request }
    end
  end
  
  def accept_friend_request
    @key_request = KeyRequest.find(params[:id])
    @key_request.accept_friend_request
    @friend = @key_request.user
    @num_received_requests = KeyRequest.received_friend_requests_for_user(current_user).count
    
    respond_to do |format|
      format.js { render layout: false }
      format.json { render json: @key_request }
    end
  end
end
