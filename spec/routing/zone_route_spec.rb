require 'spec_helper'

describe "routing to zones" do
  before :all do
    @game = Factory(:game).to_param
    @zone = Factory(:zone).to_param
    @region = Factory(:region).to_param
  end

  it "should expose a list of a game's zones" do
    {:get => "/games/#{@game}/zones"}.should route_to(:action => "index",
      :game_id => @game, :controller => "zones")
  end

  it "should expose a list of the current game's zones" do
    {:get => "/zones"}.should route_to(:action => "index", :controller => "zones")
  end

  it "should expose a list of a region's zones" do
    {:get => "/games/#{@game}/regions/#{@region}/zones"}.should route_to(
        :action => "index", :game_id => @game, :region_id => @region,
        :controller => "zones")
  end

  it "should expose a list of a region's zones in the current game" do
    {:get => "/regions/#{@region}/zones"}.should route_to(
        :action => "index", :region_id => @region, :controller => "zones")
  end

  it "should expose a hackable URL to a game's zone" do
    {:get => "/games/#{@game}/zones/#{@zone}"}.should route_to(:action => "show",
        :game_id => @game, :id => @zone, :controller => "zones")
  end

  it "should expose a hackable URL to the current game's zone" do
    {:get => "/zones/#{@zone}"}.should route_to(:action => "show", :id => @zone,
        :controller => "zones")
  end

  it "should expose a hackable URL to a region's zone" do
    {:get => "/games/#{@game}/regions/#{@region}/zones/#{@zone}"
        }.should route_to(:action => "show", :game_id => @game,
        :region_id => @region, :id => @zone, :controller => "zones")
  end

  it "should expose a hackable URL to a region's zone in the current game" do
    {:get => "/regions/#{@region}/zones/#{@zone}"
        }.should route_to(:action => "show", :region_id => @region, :id => @zone,
        :controller => "zones")
  end

  it "should expose a direct URL to a zone" do
    {:get => "/zones/#{@zone}"}.should route_to(:action => "show", :id => @zone,
      :controller => "zones")
  end

  it "does not allow editing of a zone" do
    {:put => "/zones/#{@zone}"}.should_not be_routable
  end

  it "does not allow deleting of a zone" do
    {:delete => "/zones/#{@zone}"}.should_not be_routable
  end
end
