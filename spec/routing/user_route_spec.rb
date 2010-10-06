require 'spec_helper'

describe "routing to users" do
  before :all do
    @user = Factory(:user).to_param
  end

  it { {:get => "/login"}.should route_to(:action => "new",
        :controller => "user_sessions") }

  it { {:get => "/logout"}.should route_to(:action => "destroy",
        :controller => "user_sessions") }

  it { {:post => "/authenticate"}.should route_to(:action => "create",
        :controller => "user_sessions") }

  it { {:get => "/users"}.should route_to(:action => "index",
      :controller => "users") }

  it { {:get => "/users/#{@user}"}.should route_to(:action => "show",
      :id => @user, :controller => "users") }
end
