require 'spec_helper'

describe "routing to generators" do
  before :all do
    @zone = Factory(:zone).to_param
    @generator = Factory(:generator).to_param
  end

  it "should expose a list of the current game's generators" do
    {:get => "/generators"}.should route_to(:action => "index",
        :controller => "generators")
  end

  it "should expose a direct URL to a list of a zone's generators" do
    {:get => "/zones/#{@zone}/generators"}.should route_to(
        :action => "index", :zone_id => @zone, :controller => "generators")
  end

  it { {:get => "/zones/#{@zone}/generators/new"}.should route_to(
      :action => "new", :zone_id => @zone, :controller => "generators") }

  it { {:post => "/generators"}.should route_to(:action => "create",
      :controller => "generators") }

  it "should expose a hackable URL to the current game's generator" do
    {:get => "/generators/#{@generator}"}.should route_to(
        :action => "show", :id => @generator, :controller => "generators")
  end

  it "should expose a hackable URL to a zone's generator in the current game" do
    {:get => "/zones/#{@zone}/generators/#{@generator}"
        }.should route_to(:action => "show", :zone_id => @zone, :id => @generator,
        :controller => "generators")
  end

  it "should expose a direct URL to a generator" do
    {:get => "/generators/#{@generator}"}.should route_to(:action => "show",
      :id => @generator, :controller => "generators")
  end
  
  it "should expose a hackable URL to edit a zone's generator in the current game" do
    {:get => "/zones/#{@zone}/generators/#{@generator}/edit"
        }.should route_to(:action => "edit", :zone_id => @zone, :id => @generator,
        :controller => "generators")
  end

  it "should expose a hackable URL to edit the current game's generator" do
    {:get => "/generators/#{@generator}/edit"}.should route_to(
        :action => "edit", :id => @generator, :controller => "generators")
  end

  it "should expose a direct URL to edit a generator" do
    {:get => "/generators/#{@generator}/edit"}.should route_to(:action => "edit",
      :id => @generator, :controller => "generators")
  end

  it { {:put => "/generators/#{@generator}"}.should route_to(:action => "update",
      :id => @generator, :controller => "generators") }
end
