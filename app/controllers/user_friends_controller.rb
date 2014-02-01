class UserFriendsController < ApplicationController
  
  filter_resource_access

  def remove_friend
    @user_friend = UserFriend.find(params[:id])
    @user_friend.destroy

    respond_to do |format|
      format.html { redirect_to user_friends_url }
      format.json { head :no_content }
    end
  end
  
end
