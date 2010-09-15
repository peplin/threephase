require 'spec_helper'

describe "routing to users" do
  it { {:get, "/users"}.should route_to(:action => :index,
        :controller => "users") }

  it { {:get, "/users/new"}.should route_to(:action => :new,
        :controller => "users") }

  it { {:post, "/users"}.should route_to(:action => :create,
      :controller => "users") }

  it { {:get, "/user/1"}.should route_to(:action => :show,
      :id => 1, :controller => "users") }

  it { {:get, "/user/1/edit"}.should route_to(:action => :edit,
      :id => 1, :controller => "users") }

  it { {:get, "/me/edit"}.should route_to(:action => :show,
      :controller => "users") }

  it { {:get, "/me"}.should route_to(:action => :edit,
      :controller => "users") }

  it { {:put, "/user/1"}.should route_to(:action => :update,
      :id => 1, :controller => "users") }
end
