class Leaderboard
  
  def self.public_leaderbaord
    User.where('points is not NULL').order('points desc').limit(10)
  end
  
  def self.friends_leaderboard(user)
    user.friends.scoped.order('points desc').limit(10)
  end
  
  def self.companion_leaderboard(user)
    User.scoped.select("users.*, (abs(EXTRACT(EPOCH FROM created_at - ('#{user.created_at.to_s}')::timestamp))) AS delta").order("delta").limit(10)
  end
  
end