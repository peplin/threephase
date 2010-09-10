require 'spec_helper'

describe "routing to contracts" do
  it { {:get, "/game/1/contracts"}.should route_to(:action => :index,
        :game => 1, :controller => "contracts") }

  it { {:get, "/generator/1/contracts"}.should route_to(:action => :index,
        :generator => 1, :controller => "contracts") }

  it { {:get, "/generator/1/contracts/new"}.should route_to(:action => :new,
      :game => 1, :controller => "contracts") }

  it { {:post, "/generator/1/contracts"}.should route_to(:action => :create,
      :generator => 1, :controller => "contracts") }

  it { {:post, "/generator/1/contract/2"}.should route_to(:action => :offer,
      :generator => 1, :contract => 2, :controller => "contracts") }

  it { {:put, "/generator/1/contract/2/offer/3"}.should route_to(
      :action => :respond, :generator => 1, :contract => 2, :offer => 3,
      :controller => "contracts") }

  it { {:get, "/generator/1/contract/2"}.should route_to(:action => :show,
      :generator => 1, :contract => 2, :controller => "contracts") }

  it "does not allow contract updating" do
    {:put => "/generator/1/contract/1"}.should_not be_routable
  end

  it "does not allow contract deleting" do
    {:delete => "/generator/1/contracts/1"}.should_not be_routable
  end
end
