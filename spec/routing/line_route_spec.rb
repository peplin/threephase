require 'spec_helper'

describe "routing to lines" do
  before :all do
    @line = Factory(:line).to_param
    @city = Factory(:city).to_param
  end

  it "should expose a list of a game's lines" do
    {:get => "/lines"}.should route_to(:action => "index", :controller => "lines")
  end

  it "should expose a list of a city's lines" do
    {:get => "/cities/#{@city}/lines"}.should route_to(
        :action => "index", :city_id => @city, :controller => "lines")
  end

  it { {:get => "/cities/#{@city}/lines/new"}.should route_to(
      :action => "new", :city_id => @city, :controller => "lines") }

  it { {:post => "/lines"}.should route_to(:action => "create", :controller => "lines") }

  it "should expose a direct URL to a line" do
    {:get => "/lines/#{@line}"}.should route_to(:action => "show",
        :id => @line, :controller => "lines")
  end

  it "should expose a hackable URL to a city's line" do
    {:get => "/cities/#{@city}/lines/#{@line}"}.should route_to(
        :action => "show", :city_id => @city, :id => @line, :controller => "lines")
  end

  it "should expose a direct URL to edit a line" do
    {:get => "/lines/#{@line}/edit"}.should route_to(:action => "edit",
        :id => @line, :controller => "lines")
  end

  it "should expose a hackable URL to edit a city's line" do
    {:get => "/cities/#{@city}/lines/#{@line}/edit" }.should route_to(
        :action => "edit", :city_id => @city, :id => @line, :controller => "lines")
  end

  it { {:put => "/lines/#{@line}"}.should route_to(:action => "update",
        :id => @line, :controller => "lines") }
end
