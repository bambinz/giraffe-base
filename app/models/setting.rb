class Setting < ActiveRecord::Base
  attr_accessible :show_in_search, :accept_friend_reqests, :public_profile, :public_attributes
  serialize :public_attributes, JSON
  belongs_to :user
  
  def set_defaults
    self.show_in_search = true
    self.accept_friend_reqests = true
    self.public_profile = true
    self.save
  end
  
end
