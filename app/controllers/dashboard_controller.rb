class DashboardController < ApplicationController
  
  def show
    @leaderboard_all_users = Leaderboard.public_leaderbaord
    @leaderboard_friends_users = Leaderboard.friends_leaderboard(current_user)
    @leaderboard_companions_users = Leaderboard.companion_leaderboard(current_user)
  end
  
end
