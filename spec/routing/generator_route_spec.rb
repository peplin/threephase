require 'spec_helper'

describe "routing to generators" do
  before :all do
    @city = Factory(:city).to_param
    @generator = Factory(:generator).to_param
  end

  it "should expose a list of the current game's generators" do
    {:get => "/generators"}.should route_to(:action => "index",
        :controller => "generators")
  end

  it "should expose a direct URL to a list of a city's generators" do
    {:get => "/cities/#{@city}/generators"}.should route_to(
        :action => "index", :city_id => @city, :controller => "generators")
  end

  it { {:get => "/cities/#{@city}/generators/new"}.should route_to(
      :action => "new", :city_id => @city, :controller => "generators") }

  it { {:post => "/generators"}.should route_to(:action => "create",
      :controller => "generators") }

  it "should expose a hackable URL to the current game's generator" do
    {:get => "/generators/#{@generator}"}.should route_to(
        :action => "show", :id => @generator, :controller => "generators")
  end

  it "should expose a hackable URL to a city's generator in the current game" do
    {:get => "/cities/#{@city}/generators/#{@generator}"
        }.should route_to(:action => "show", :city_id => @city,
          :id => @generator, :controller => "generators")
  end

  it "should expose a direct URL to a generator" do
    {:get => "/generators/#{@generator}"}.should route_to(:action => "show",
      :id => @generator, :controller => "generators")
  end
  
  it "should expose a hackable URL to edit a city's gen. in the current game" do
    {:get => "/cities/#{@city}/generators/#{@generator}/edit"
        }.should route_to(:action => "edit", :city_id => @city,
          :id => @generator, :controller => "generators")
  end

  it "should expose a hackable URL to edit the current game's generator" do
    {:get => "/generators/#{@generator}/edit"}.should route_to(
        :action => "edit", :id => @generator, :controller => "generators")
  end

  it "should expose a direct URL to edit a generator" do
    {:get => "/generators/#{@generator}/edit"}.should route_to(
        :action => "edit", :id => @generator, :controller => "generators")
  end

  it "should expose a direct URL to a generator's average operating levels" do
    {:get => "/generators/#{@generator}/levels"}.should route_to(
        :action => "levels", :id => @generator, :controller => "generators")
  end

  it { {:put => "/generators/#{@generator}"}.should route_to(
      :action => "update", :id => @generator, :controller => "generators") }
end
