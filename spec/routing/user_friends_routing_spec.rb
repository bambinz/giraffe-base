require "spec_helper"

describe UserFriendsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_friends").should route_to("user_friends#index")
    end

    it "routes to #new" do
      get("/user_friends/new").should route_to("user_friends#new")
    end

    it "routes to #show" do
      get("/user_friends/1").should route_to("user_friends#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_friends/1/edit").should route_to("user_friends#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_friends").should route_to("user_friends#create")
    end

    it "routes to #update" do
      put("/user_friends/1").should route_to("user_friends#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_friends/1").should route_to("user_friends#destroy", :id => "1")
    end

  end
end
