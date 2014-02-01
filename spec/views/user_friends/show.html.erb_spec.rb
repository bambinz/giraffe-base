require 'spec_helper'

describe "user_friends/show" do
  before(:each) do
    @user_friend = assign(:user_friend, stub_model(UserFriend))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
