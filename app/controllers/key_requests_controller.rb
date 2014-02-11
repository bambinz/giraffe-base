class KeyRequestsController < ApplicationController

  filter_access_to :all, except: [:send_friend_request]

  def list_friend_requests
    @key_requests = KeyRequest.list_friend_requests_for_user(current_user)
  end

  def send_friend_request
    @request = KeyRequest.generate_friend_request(current_user, User.find(params[:friend_id]))
  end

  def accept_friend_request
    @key_request = KeyRequest.find(params[:id])
    @key_request.accept_friend_request
    @friend = @key_request.user
    @num_received_requests = KeyRequest.received_friend_requests_for_user(current_user).count
  end

  def ignore_friend_request
    @key_request = KeyRequest.find(params[:id])
    @key_request.ignore_friend_request
    @num_received_requests = KeyRequest.received_friend_requests_for_user(current_user).count
  end

  def remove_friend_request
    @key_request = KeyRequest.find(params[:id])
    @key_request_id = @key_request.id
    @key_request.remove_friend_request
    @num_sent_requests = KeyRequest.sent_friend_requests_for_user(current_user).count
  end
end
