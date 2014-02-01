require 'spec_helper'

describe "user_friends/new" do
  before(:each) do
    assign(:user_friend, stub_model(UserFriend).as_new_record)
  end

  it "renders new user_friend form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_friends_path, "post" do
    end
  end
end
