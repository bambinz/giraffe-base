class UserFriendsController < ApplicationController
  
  filter_resource_access

  def remove_friend
    @user_friend = UserFriend.find(params[:id])
    @user_friend.destroy

    redirect_to user_friends_url
  end
  
end
