desc "Create Badges"
task :create_badges => :environment do
  
  create_badge("Newbie", "Register an account and sign in", Badge::BadgeTypes::SIGN_UP)
  create_badge("Attention to Detail", "Complete your profile", Badge::BadgeTypes::COMPLETE_PROFILE)
  create_badge("The Friendly", "Add a friend", Badge::BadgeTypes::ADD_FRIEND)
  create_badge("The Popular", "Add 10 friends", Badge::BadgeTypes::ADD_FRIEND, 10, Badge::BadgeLevels::SILVER)
  create_badge("Celebrity", "Add 50 friends", Badge::BadgeTypes::ADD_FRIEND, 50, Badge::BadgeLevels::GOLD)
  
  puts "Done."
end

def create_badge(name, description, type, stage = 1, level = Badge::BadgeLevels::BRONZE)
  b = Badge.where(badge_type: type, stage: stage).first
  if !b
    b = Badge.new
    b.badge_type = type
  end
  b.name = name
  b.description = description
  b.badge_type = type
  b.level = level
  b.stage = stage
  b.save
end