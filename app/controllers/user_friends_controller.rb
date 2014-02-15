class UserFriendsController < ApplicationController
  
  filter_access_to :all, except: [:remove_friend]

  def remove_friend
    if UserFriend.remove_friend(@current_user.id, params[:friend_id])
      redirect_to user_path(@current_user)
    end
  end
  
end
