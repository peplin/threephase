require 'spec_helper'

describe "routing to zones" do
  before :all do
    @game = Game.all.first
    @zone = Zone.all.first
    @region = REgion.all.first
  end

  it { {:get, "/game/#{@game}/zones"}.should route_to(:action => :index,
      :game => @game, :controller => "zones") }

  it { {:get, "/game/#{@game}/region/#{@region}/zones"}.should route_to(:action => :index,
      :game => @game, :region => @region, :controller => "zones") }

  it { {:post, "/zones"}.should route_to(:action => :create,
      :controller => "zones") }

  it { {:get, "/zone/#{@zone}"}.should route_to(:action => :show, :id => @zone,
      :controller => "zones") }

  it "does not expose a list of all zones" do
    {:get => "/zones"}.should_not be_routable
  end

  it "does not allow editing of a zone" do
    {:put => "/zone/#{@zone}"}.should_not be_routable
  end

  it "does not allow deleting of a zone" do
    {:delete => "/zone/#{@zone}"}.should_not be_routable
  end
end
