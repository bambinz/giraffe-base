require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    describe "as admin" do
      before do
        activate_authlogic
        sign_in FactoryGirl.create(:admin)
      end
      it "should show the index users page" do
        visit users_path
        page.should have_content("Listing users")
      end
    end

    describe "as user" do
      before do
        activate_authlogic
        sign_in FactoryGirl.create(:user)
      end
      it "should redirect to home page" do
        get users_path
        response.code.should == "302"
        response.should redirect_to(root_path)
      end
    end

    describe "while not logged in" do
      it "should redirect to home page" do
        get users_path
        response.code.should == "302"
        response.should redirect_to(root_path)
      end
    end
  end
end

def sign_in(user)
  visit login_path
  fill_in "Username", :with => user.username
  fill_in "Password", :with => user.password
  click_button "Login"
end
