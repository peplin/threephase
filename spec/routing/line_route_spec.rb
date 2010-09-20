require 'spec_helper'

describe "routing to lines" do
  before :each do
    @game = Factory(:game).to_param
    @line = Factory(:line).to_param
    @zone = Factory(:zone).to_param
  end

  it "should expose a list of a game's lines" do
    {:get, "/games/#{@game}/lines"}.should route_to(:action => "index",
      :game_id => @game, :controller => "lines")
  end

  it "should expose a list of a zone's lines" do
    {:get, "/games/#{@game}/zones/#{@zone}/lines"}.should route_to(
        :action => "index", :game_id => @game, :zone_id => @zone,
        :controller => "lines")
  end

  it { {:get, "/games/#{@game}/zones/#{@zone}/lines/new"}.should route_to(
      :action => "new", :game_id => @game, :zone_id => @zone,
      :controller => "lines") }

  it { {:post, "/lines"}.should route_to(:action => "create",
      :controller => "lines") }

  it "should expose a direct URL to a line" do
    {:get, "/lines/#{@line}"}.should route_to(:action => "show",
        :id => @line, :controller => "lines")
  end

  it "should expose a hackable URL to a zone's line" do
    {:get, "/games/#{@game}/zones/#{@zone}/lines/#{@line}"}.should route_to(
        :action => "show", :game_id => @game, :zone_id => @zone, :id => @line,
        :controller => "lines")
  end

  it "should expose a direct URL to edit a line" do
    {:get, "/lines/#{@line}/edit"}.should route_to(:action => "edit",
        :id => @line, :controller => "lines")
  end

  it "should expose a hackable URL to edit a zone's line" do
    {:get, "/games/#{@game}/zones/#{@zone}/lines/#{@line}/edit"
        }.should route_to(:action => "edit", :game_id => @game,
        :zone_id => @zone, :id => @line, :controller => "lines")
  end

  it { {:put, "/lines/#{@line}"}.should route_to(:action => "update",
        :id => @line, :controller => "lines") }

  it "does not expose a list of all lines" do
    {:get => "/lines"}.should_not be_routable
  end
end
