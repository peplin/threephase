require 'spec_helper'

describe "routing to lines" do
  before :all do
    @game = Game.all.first
    @line = IntererstateLine.all.first
    @zone = Zone.all.first
  end

  it { {:get, "/game/#{@game}/lines"}.should route_to(:action => :index,
      :game => @game, :controller => "lines") }

  it { {:get, "/game/#{@game}/zone/#{@zone}/lines"}.should route_to(:action => :index,
      :game => @game, :zone => @zone, :controller => "lines") }

  it { {:get, "/game/#{@game}/line/new"}.should route_to(:action => :new,
      :game => @game, :controller => "lines") }

  it { {:post, "/lines"}.should route_to(:action => :create,
      :controller => "lines") }

  it { {:get, "/line/#{@line}"}.should route_to(:action => :show,
        :id => @line, :controller => "lines") }

  it { {:get, "/line/#{@line}/edit"}.should route_to(:action => :edit,
        :id => @line, :controller => "lines") }

  it { {:put, "/line/#{@line}"}.should route_to(:action => :update,
        :id => @line, :controller => "lines") }

  it "does not expose a list of all lines" do
    {:get => "/lines"}.should_not be_routable
  end
end
