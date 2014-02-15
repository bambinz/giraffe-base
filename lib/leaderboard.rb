class Leaderboard
  
  def self.public_leaderbaord
    User.where('points is not NULL').order('points desc').limit(10)
  end
  
  def self.friends_leaderboard(user)
    user.friends.scoped.order('points desc').limit(10)
  end
  
  def self.companion_leaderboard
    #get users that were created at a similar time
  end
  
  
end