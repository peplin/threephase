require 'spec_helper'

describe "routing to repairs" do
  before :all do
    @game = Game.all.first
    @generator = Generator.all.first
    @repair = Repair.all.first
  end

  it { {:get, "/game/#{@game}/repairs"}.should route_to(:action => :index,
      :game => @game, :controller => "repairs") }

  it { {:get, "/generator/#{@generator}/repairs"}.should route_to(
      :action => :index, :generator => @generator, :controller => "repairs") }

  it { {:post, "/repairs"}.should route_to(:action => :create,
      :controller => "repairs") }

  it { {:get, "/repair/#{@repair}"}.should route_to(:action => :show,
        :id => @repair, :controller => "repairs") }

  it "does not expose a list of all repairs" do
    {:get => "/repairs"}.should_not be_routable
  end

  it "does not allow editing of a repair" do
    {:put => "/repair/#{@repair}" }.should_not be_routable
  end

  it "does not allow deleting of a repair" do
    {:delete => "/repair/#{@repair}" }.should_not be_routable
  end
end
