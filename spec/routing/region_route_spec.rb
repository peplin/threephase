require 'spec_helper'

describe "routing to regions" do
  before :all do
    @game = Game.all.first
    @region = Region.all.first
    @market = Market.all.first
  end

  it { {:get, "/game/#{@game}/regions"}.should route_to(:action => :index,
      :game => @game, :controller => "regions") }

  it { {:get, "/game/#{@game}/region/#{@region}"}.should route_to(
      :action => :show, :game => @game, :region => @region,
      :controller => "regions") }

  # TODO do we need post? how are players added to a game?

  it { {:put, "/game/#{@game}/region/#{@region}"}.should route_to(
      :action => :update, :game => @game, :region => @region,
      :controller => "regions") }

  it "does not expose a list of all regions" do
    {:get => "/regions"}.should_not be_routable
  end

  it "does not allow creating new regions" do
    {:post => "/game/#{@game}/regions"}.should_not be_routable
    {:post => "/regions"}.should_not be_routable
  end

  it "does not allow deleting of a region" do
    {:delete => "/region/#{@region}"}.should_not be_routable
  end
end
