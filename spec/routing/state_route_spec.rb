require 'spec_helper'

describe "routing to states" do
  before :all do
    @game = Factory(:game).to_param
    @state = Factory(:state).to_param
  end

  it { {:get => "/games/#{@game}/states"}.should route_to(:action => "index",
      :game_id => @game, :controller => "states") }

  it "should expose a hackable URL to the current game's states" do
    {:get => "/states"}.should route_to(:action => "index", :controller => "states")
  end

  it "should expose a hackable URL to a game's state" do
    {:get => "/games/#{@game}/states/#{@state}"}.should route_to(
      :action => "show", :game_id => @game, :id => @state,
      :controller => "states")
  end

  it "should expose a direct URL to a state" do
    {:get => "/states/#{@state}"}.should route_to(
      :action => "show", :id => @state,
      :controller => "states")
  end

  it "should expose a direct URL to edit a game's state" do
    {:get => "/states/#{@state}/edit"}.should route_to(
      :action => "edit", :id => @state, :controller => "states")
  end

  it "should expose a direct URL to a new state form for a game" do
    {:get => "/games/#{@game}/states/new"}.should route_to(
        :action => "new", :game_id => @game, :controller => "states")
  end

  it { {:post => "/states"}.should route_to(:action => "create",
      :controller => "states") }

  it { {:put => "/states/#{@state}"}.should route_to(
      :action => "update", :id => @state,
      :controller => "states") }

  it "should expose a direct URL to destroy a state" do
    {:delete => "/states/#{@state}"}.should route_to(
      :action => "destroy", :id => @state,
      :controller => "states") 
  end
end
