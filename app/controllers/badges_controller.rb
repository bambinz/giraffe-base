class BadgesController < ApplicationController

  def index
    @bronze_badges = Badge.where(level: Badge::BadgeLevels::BRONZE)
    @silver_badges = Badge.where(level: Badge::BadgeLevels::SILVER)
    @gold_badges = Badge.where(level: Badge::BadgeLevels::GOLD)
    @platinum_badges = Badge.where(level: Badge::BadgeLevels::PLATINUM)
  end
end
