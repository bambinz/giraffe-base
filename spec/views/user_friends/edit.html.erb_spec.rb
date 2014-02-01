require 'spec_helper'

describe "user_friends/edit" do
  before(:each) do
    @user_friend = assign(:user_friend, stub_model(UserFriend))
  end

  it "renders the edit user_friend form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_friend_path(@user_friend), "post" do
    end
  end
end
