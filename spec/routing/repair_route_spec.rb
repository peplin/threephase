require 'spec_helper'

describe "routing to repairs" do
  before :all do
    @game = Factory(:game).to_param
    @generator = Factory(:generator).to_param
    @store = Factory(:storage_device).to_param
    @line = Factory(:line).to_param
    @repair = Factory(:repair).to_param
  end

  it "should expose a list of a game's repairs" do
    {:get, "/games/#{@game}/repairs"}.should route_to(:action => "index",
      :game_id => @game, :controller => "repairs")
  end

  it "should expose a list of a generator's repairs" do
    {:get, "/games/#{@game}/generators/#{@generator}/repairs"}.should route_to(
      :action => "index", :game_id => @game, :generator_id => @generator,
      :controller => "repairs")
  end

  it "should expose a list of a storage device's repairs" do
    {:get, "/games/#{@game}/stores/#{@store}/repairs"}.should route_to(
      :action => "index", :game_id => @game, :storage_device_id => @store,
      :controller => "repairs")
  end

  it "should expose a list of a line's repairs" do
    {:get, "/games/#{@game}/lines/#{@line}/repairs"}.should route_to(
      :action => "index", :game_id => @game, :line_id => @line,
      :controller => "repairs")
  end

  it { {:post, "/repairs"}.should route_to(:action => "create",
      :controller => "repairs") }

  it "should expose a direct URL to a repair" do
    {:get, "/repairs/#{@repair}"}.should route_to(:action => "show",
        :id => @repair, :controller => "repairs")
  end

  it "should expose a hackable URL to a generator's repair" do
    {:get, "/games/#{@game}/generators/#{@generator}/repairs/#{@repair}"
        }.should route_to(:action => "show", :game_id => @game,
        :generator_id => @generator, :id => @repair, :controller => "repairs")
  end

  it "should expose a hackable URL to a game's repair" do
    {:get, "/games/#{@game}/repairs/#{@repair}"}.should route_to(
        :action => "show", :game_id => @game, :id => @repair,
        :controller => "repairs")
  end

  it "does not expose a list of all repairs" do
    {:get => "/repairs"}.should_not be_routable
  end

  it "does not allow editing of a repair" do
    {:put => "/repairs/#{@repair}" }.should_not be_routable
  end

  it "does not allow deleting of a repair" do
    {:delete => "/repairs/#{@repair}" }.should_not be_routable
  end
end
