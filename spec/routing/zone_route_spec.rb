require 'spec_helper'

describe "routing to zones" do
  before :all do
    @game = Factory(:game).to_param
    @zone = Factory(:zone).to_param
    @state = Factory(:state).to_param
  end

  it "should expose a list of a game's zones" do
    {:get => "/games/#{@game}/zones"}.should route_to(:action => "index",
      :game_id => @game, :controller => "zones")
  end

  it "should expose a list of the current game's zones" do
    {:get => "/zones"}.should route_to(:action => "index", :controller => "zones")
  end

  it "should expose a list of a state's zones" do
    {:get => "/games/#{@game}/states/#{@state}/zones"}.should route_to(
        :action => "index", :game_id => @game, :state_id => @state,
        :controller => "zones")
  end

  it "should expose a list of a state's zones in the current game" do
    {:get => "/states/#{@state}/zones"}.should route_to(
        :action => "index", :state_id => @state, :controller => "zones")
  end

  it "should expose a hackable URL to a game's zone" do
    {:get => "/games/#{@game}/zones/#{@zone}"}.should route_to(:action => "show",
        :game_id => @game, :id => @zone, :controller => "zones")
  end

  it "should expose a hackable URL to the current game's zone" do
    {:get => "/zones/#{@zone}"}.should route_to(:action => "show", :id => @zone,
        :controller => "zones")
  end

  it "should expose a hackable URL to a state's zone" do
    {:get => "/games/#{@game}/states/#{@state}/zones/#{@zone}"
        }.should route_to(:action => "show", :game_id => @game,
        :state_id => @state, :id => @zone, :controller => "zones")
  end

  it "should expose a hackable URL to a state's zone in the current game" do
    {:get => "/states/#{@state}/zones/#{@zone}"
        }.should route_to(:action => "show", :state_id => @state, :id => @zone,
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
