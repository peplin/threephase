require 'spec_helper'

describe "routing to contracts" do
  it { {:get, "/game/1/contracts"}.should route_to(:action => :index,
        :game => 1, :controller => "contracts") }

  it { {:get, "/generator/1/contracts"}.should route_to(:action => :index,
        :generator => 1, :controller => "contracts") }

  it { {:get, "/generator/1/contracts/new"}.should route_to(:action => :new,
      :game => 1, :controller => "contracts") }

  it { {:post, "/contracts"}.should route_to(:action => :create,
      :controller => "contracts") }

  it { {:post, "/contracts/2"}.should route_to(:action => :offer,
      :contract => 2, :controller => "contracts") }

  it { {:put, "/offer/3"}.should route_to(:action => :respond, :offer => 3,
      :controller => "contracts") }

  it { {:get, "/generators/1/contracts/2"}.should route_to(:action => :show,
      :generator => 1, :contract => 2, :controller => "contracts") }

  it { {:get, "/games/1/contracts/2"}.should route_to(:action => :show,
      :game => 1, :contract => 2, :controller => "contracts") }

  it { {:get, "/contracts/2"}.should route_to(:action => :show,
      :contract => 2, :controller => "contracts") }

  it "does not allow contract updating" do
    {:put => "/contracts/1"}.should_not be_routable
  end

  it "does not allow contract deleting" do
    {:delete => "/contracts/1"}.should_not be_routable
  end
end
