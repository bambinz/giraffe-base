require 'spec_helper'

describe "UserSessions" do
  describe "login page" do
    it "should be successful" do
      get login_path
      response.status.should be(200)
    end

    describe "with correct credentials" do
      it "should login" do
        user = FactoryGirl.create :user
        puts "user: #{user.to_json}"
        visit login_path
        fill_in "Username", :with => user.username
        fill_in "Password", :with => user.password
        click_button "Login"
        page.should have_link("Log out")
      end
    end
    
    describe "with incorrect credentials" do
      it "should not login" do
        visit login_path
        fill_in "Username", :with => "wrong username"
        fill_in "Password", :with => "wrong password"
        click_button "Login"
        page.should have_link("Log in")
      end
    end
  end
end
