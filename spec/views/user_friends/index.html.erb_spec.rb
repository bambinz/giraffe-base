require 'spec_helper'

describe "user_friends/index" do
  before(:each) do
    assign(:user_friends, [
      stub_model(UserFriend),
      stub_model(UserFriend)
    ])
  end

  it "renders a list of user_friends" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
