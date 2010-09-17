require 'spec_helper'

describe "routing to lines" do
  before :all do
    @game = Game.all.first
    @line = Line.all.first
    @zone = Zone.all.first
  end

  it "should expose a list of a game's lines" do
    {:get, "/games/#{@game}/lines"}.should route_to(:action => :index,
      :game => @game, :controller => "lines")
  end

  it "should expose a list of a zone's lines" do
    {:get, "/games/#{@game}/zone/#{@zone}/lines"}.should route_to(
        :action => :index, :game => @game, :zone => @zone,
        :controller => "lines")
  end

  it { {:get, "/games/#{@game}/zone/#{@zone}/lines/new"}.should route_to(
      :action => :new, :game => @game, :zone => @zone, :controller => "lines") }

  it { {:post, "/lines"}.should route_to(:action => :create,
      :controller => "lines") }

  it "should expose a direct URL to a line" do
    {:get, "/lines/#{@line}"}.should route_to(:action => :show,
        :id => @line, :controller => "lines")
  end

  it "should expose a hackable URL to a zone's line" do
    {:get, "/games/#{@game}/zones/#{@zone}/lines/#{@line}"}.should route_to(
        :action => :show, :game => @game, :zone => @zone, :id => @line,
        :controller => "lines")
  end

  it "should expose a direct URL to edit a line" do
    {:get, "/lines/#{@line}/edit"}.should route_to(:action => :edit,
        :id => @line, :controller => "lines")
  end

  it "should expose a hackable URL to edit a zone's line" do
    {:get, "/games/#{@game}/zones/#{@zone}/lines/#{@line}/edit"}.should route_to(
        :action => :edit, :game => @game, :zone => @zone, :id => @line,
        :controller => "lines")
  end

  it { {:put, "/lines/#{@line}"}.should route_to(:action => :update,
        :id => @line, :controller => "lines") }

  it "does not expose a list of all lines" do
    {:get => "/lines"}.should_not be_routable
  end
end
