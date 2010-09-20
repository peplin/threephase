require 'spec_helper'

describe "routing to generators" do
  before :each do
    @game = Factory(:game).to_param
    @zone = Factory(:zone).to_param
    @generator = Factory(:generator).to_param
  end

  it "should expose a list of a game's generators" do
    {:get, "/games/#{@game}/generators"}.should route_to(:action => "index",
        :game_id => @game, :controller => "generators")
  end

  it "should expose a list of a zone's generators" do
    {:get, "/games/#{@game}/zones/#{@zone}/generators"}.should route_to(
        :action => "index", :game_id => @game, :zone_id => @zone,
        :controller => "generators")
  end

  it { {:get, "/games/#{@game}/zones/#{@zone}/generators/new"}.should route_to(
      :action => "new", :game_id => @game, :zone_id => @zone,
      :controller => "generators") }

  it { {:post, "/generators"}.should route_to(:action => "create",
      :controller => "generators") }

  it "should expose a hackable URL to a game's generator" do
    {:get, "/games/#{@game}/generators/#{@generator}"}.should route_to(
        :action => "show", :game_id => @game, :id => @generator,
        :controller => "generators")
  end

  it "should expose a hackable URL to a zone's generator" do
    {:get, "/games/#{@game}/zones/#{@zone}/generators/#{@generator}"
        }.should route_to(:action => "show", :game_id => @game,
        :zone_id => @zone, :id => @generator, :controller => "generators")
  end

  it "should expose a direct URL to a generator" do
    {:get, "/generators/#{@generator}"}.should route_to(:action => "show",
      :id => @generator, :controller => "generators")
  end

  it "should expose a hackable URL to edit a zone's generator" do
    {:get, "/games/#{@game}/zones/#{@zone}/generators/#{@generator}/edit"
        }.should route_to(:action => "edit", :game_id => @game,
        :zone_id => @zone, :id => @generator, :controller => "generators")
  end

  it "should expose a hackable URL to edit a game's generator" do
    {:get, "/games/#{@game}/generators/#{@generator}/edit"}.should route_to(
        :action => "edit", :game_id => @game, :id => @generator,
        :controller => "generators")
  end

  it "should expose a direct URL to edit a generator" do
    {:get, "/generators/#{@generator}/edit"}.should route_to(:action => "edit",
      :id => @generator, :controller => "generators")
  end

  it { {:put, "/generators/#{@generator}"}.should route_to(:action => "update",
      :id => @generator, :controller => "generators") }

  it "does not expose a list of all generators" do
    {:get => "/generators"}.should_not be_routable
  end
end
