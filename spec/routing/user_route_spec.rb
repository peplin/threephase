require 'spec_helper'

describe "routing to users" do
  before :all do
    @user = User.all.first
  end

  it { {:get, "/users"}.should route_to(:action => :index,
        :controller => "users") }

  it { {:get, "/users/new"}.should route_to(:action => :new,
        :controller => "users") }

  it { {:post, "/users"}.should route_to(:action => :create,
      :controller => "users") }

  it { {:get, "/users/#{@user}"}.should route_to(:action => :show,
      :id => @user, :controller => "users") }

  it { {:get, "/users/#{@user}/edit"}.should route_to(:action => :edit,
      :id => @user, :controller => "users") }

  it { {:get, "/me/edit"}.should route_to(:action => :show,
      :controller => "users") }

  it { {:get, "/me"}.should route_to(:action => :edit,
      :controller => "users") }

  it { {:put, "/users/#{@user}"}.should route_to(:action => :update,
      :id => @user, :controller => "users") }
end
