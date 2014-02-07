class Setting < ActiveRecord::Base
  attr_accessible :show_in_search, :accept_friend_reqests, :public_profile, :public_attributes
  serialize :public_attributes, JSON
  belongs_to :user
  
  def set_defaults
    show_in_search = true
    accept_friend_reqests = true
    public_profile = true
    self.save
  end
  
end
