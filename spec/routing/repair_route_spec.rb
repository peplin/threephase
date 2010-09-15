require 'spec_helper'

describe "routing to repairs" do
  it { {:get, "/game/1/repairs"}.should route_to(:action => :index,
      :game => 1, :controller => "repairs") }

  it { {:get, "/generator/1/repairs"}.should route_to(:action => :index,
      :generator => 1, :controller => "repairs") }

  it { {:post, "/repairs"}.should route_to(:action => :create,
      :controller => "repairs") }

  it { {:get, "/repair/1"}.should route_to(:action => :show,
        :id => 1, :controller => "repairs") }

  it "does not expose a list of all repairs" do
    {:get => "/repairs"}.should_not be_routable
  end

  it "does not allow editing of a repair" do
    {:put => "/generator/1/repair/1"}.should_not be_routable
  end

  it "does not allow deleting of a repair" do
    {:delete => "/generator/1/repair/1"}.should_not be_routable
  end
end
