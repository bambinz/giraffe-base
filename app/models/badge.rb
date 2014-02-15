class Badge < ActiveRecord::Base
  module BadgeLevels
    BRONZE = 0
    SILVER = 1
    GOLD = 2
    PLATINUM = 3
  end
  
  module BadgeTypes
    SIGN_UP = 0
    COMPLETE_PROFILE = 1
    ADD_FRIEND = 2
  end
  
  BADGE_LEVELS = { 0 => "Bronze", 1 => "Silver", 2 => "Gold", 3 => "Platinum"}
  
  def self.award_badge(user, type, stage = 1)
    badge_to_award = Badge.where(badge_type: type, stage: stage).first

    if !badge_to_award
      return nil
    end

    if user.badges.include?(badge_to_award)
      return nil
    end
    
    ub = UserBadge.new
    ub.badge_id = badge_to_award.id
    ub.user_id = user.id
    res = ub.save
    
    if res
      Notification.badge_awarded_notification(user, badge_to_award)
      return badge_to_award
    end
  end
  
  def self.add_friend_badge(user)
    if user.friends.count == 50
      b = award_badge(user, BadgeTypes::ADD_FRIEND, 50)
    elsif user.friends.count == 10
      b = award_badge(user, BadgeTypes::ADD_FRIEND, 10)
    elsif user.friends.count >= 1
      b = award_badge(user, BadgeTypes::ADD_FRIEND, 1)
    end
    return b
  end
end
