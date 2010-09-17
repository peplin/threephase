require 'spec_helper'

describe "routing to generators" do
  before :all do
    @game = Game.all.first
    @zone = Zone.all.first
  end

  it { {:get, "/game/#{@game}/generators"}.should route_to(:action => :index,
        :game => @game, :controller => "generators") }

  it { {:get, "/game/#{@game}/zone/#{@zone}/generators"}.should route_to(:action => :index,
      :game => @game, :zone => @zone, :controller => "generators") }

  it { {:get, "/game/#{@game}/generators/new"}.should route_to(:action => :new,
      :game => @game, :controller => "generators") }

  it { {:get, "/game/#{@game}/zone/#{@zone}/generators/new"}.should route_to(:action => :new,
      :game => @game, :zone => @zone, :controller => "generators") }

  it { {:post, "/generators"}.should route_to(:action => :create,
      :controller => "generators") }

  it { {:get, "/generator/#{@generator}"}.should route_to(:action => :show,
      :id => @generator, :controller => "generators") }

  it { {:get, "/generator/#{@generator}/edit"}.should route_to(:action => :edit,
      :id => @generator, :controller => "generators") }

  it { {:put, "/generator/#{@generator}"}.should route_to(:action => :update,
      :id => @generator, :controller => "generators") }

  it "does not expose a list of all generators" do
    {:get => "/generators"}.should_not be_routable
  end
end
