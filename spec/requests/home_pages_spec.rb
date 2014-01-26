require 'spec_helper'

describe "HomePages" do

  describe "visit home page while not logged in" do
    it "should be successful" do
      visit root_path
      response.status.should be(200)
      page.should have_link("Log in")
      page.should have_link("Register")
    end
  end

  describe "visit home page while logged in" do
    before do
      activate_authlogic
      user = FactoryGirl.create(:user)
      UserSession.create(user)
    end
    
    it "should be successful" do
      visit root_path
      response.status.should be(200)
      page.should have_link("Log out")
    end
  end
end
