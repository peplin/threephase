require 'spec_helper'

describe "routing to cities" do
  before :all do
    @game = Factory(:game).to_param
    @city = Factory(:city).to_param
    @state = Factory(:state).to_param
  end

  it "should expose a list of a game's cities" do
    {:get => "/games/#{@game}/cities"}.should route_to(:action => "index",
      :game_id => @game, :controller => "cities")
  end

  it "should expose a list of the current game's cities" do
    {:get => "/cities"}.should route_to(:action => "index", :controller => "cities")
  end

  it "should expose a list of a state's cities" do
    {:get => "/games/#{@game}/states/#{@state}/cities"}.should route_to(
        :action => "index", :game_id => @game, :state_id => @state,
        :controller => "cities")
  end

  it "should expose a list of a state's cities in the current game" do
    {:get => "/states/#{@state}/cities"}.should route_to(
        :action => "index", :state_id => @state, :controller => "cities")
  end

  it "should expose a hackable URL to a game's city" do
    {:get => "/games/#{@game}/cities/#{@city}"}.should route_to(:action => "show",
        :game_id => @game, :id => @city, :controller => "cities")
  end

  it "should expose a hackable URL to the current game's city" do
    {:get => "/cities/#{@city}"}.should route_to(:action => "show", :id => @city,
        :controller => "cities")
  end

  it "should expose a hackable URL to a state's city" do
    {:get => "/games/#{@game}/states/#{@state}/cities/#{@city}"
        }.should route_to(:action => "show", :game_id => @game,
        :state_id => @state, :id => @city, :controller => "cities")
  end

  it "should expose a hackable URL to a state's city in the current game" do
    {:get => "/states/#{@state}/cities/#{@city}"
        }.should route_to(:action => "show", :state_id => @state, :id => @city,
        :controller => "cities")
  end

  it "should expose a direct URL to a city" do
    {:get => "/cities/#{@city}"}.should route_to(:action => "show", :id => @city,
      :controller => "cities")
  end

  it "does not allow editing of a city" do
    {:put => "/cities/#{@city}"}.should_not be_routable
  end

  it "does not allow deleting of a city" do
    {:delete => "/cities/#{@city}"}.should_not be_routable
  end
end
