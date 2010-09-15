require 'spec_helper'

describe "routing to lines" do
  it { {:get, "/game/1/lines"}.should route_to(:action => :index,
      :game => 1, :controller => "lines") }

  it { {:get, "/game/1/zone/2/lines"}.should route_to(:action => :index,
      :game => 1, :zone => 2, :controller => "lines") }

  it { {:get, "/game/1/line/new"}.should route_to(:action => :new,
      :game => 1, :controller => "lines") }

  it { {:post, "/lines"}.should route_to(:action => :create,
      :controller => "lines") }

  it { {:get, "/line/1"}.should route_to(:action => :show,
        :id => 1, :controller => "lines") }

  it { {:get, "/line/1/edit"}.should route_to(:action => :edit,
        :id => 1, :controller => "lines") }

  it { {:put, "/line/1"}.should route_to(:action => :update,
        :id => 1, :controller => "lines") }

  it "does not expose a list of all lines" do
    {:get => "/lines"}.should_not be_routable
  end
end
