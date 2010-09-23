require 'spec_helper'

describe "routing to regions" do
  before :all do
    @game = Factory(:game).to_param
    @region = Factory(:region).to_param
    @market = Factory(:market).to_param
  end

  it { {:get, "/games/#{@game}/regions"}.should route_to(:action => "index",
      :game_id => @game, :controller => "regions") }

  it "should expose a hackable URL to a game's region" do
    {:get, "/games/#{@game}/regions/#{@region}"}.should route_to(
      :action => "show", :game_id => @game, :id => @region,
      :controller => "regions")
  end

  it "should expose a direct URL to a region" do
    {:get, "/regions/#{@region}"}.should route_to(
      :action => "show", :id => @region,
      :controller => "regions")
  end

  # TODO do we need post? how are players added to a game?

  it { {:put, "/regions/#{@region}"}.should route_to(
      :action => "update", :id => @region,
      :controller => "regions") }

  it "does not expose a list of all regions" do
    {:get => "/regions"}.should_not be_routable
  end

  it "does not allow creating new regions" do
    {:post => "/games/#{@game}/regions"}.should_not be_routable
    {:post => "/regions"}.should_not be_routable
  end

  it "does not allow deleting of a region" do
    {:delete => "/regions/#{@region}"}.should_not be_routable
  end
end
