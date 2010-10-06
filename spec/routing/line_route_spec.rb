require 'spec_helper'

describe "routing to lines" do
  before :all do
    @line = Factory(:line).to_param
    @zone = Factory(:zone).to_param
  end

  it "should expose a list of a game's lines" do
    {:get => "/lines"}.should route_to(:action => "index", :controller => "lines")
  end

  it "should expose a list of a zone's lines" do
    {:get => "/zones/#{@zone}/lines"}.should route_to(
        :action => "index", :zone_id => @zone, :controller => "lines")
  end

  it { {:get => "/zones/#{@zone}/lines/new"}.should route_to(
      :action => "new", :zone_id => @zone, :controller => "lines") }

  it { {:post => "/lines"}.should route_to(:action => "create", :controller => "lines") }

  it "should expose a direct URL to a line" do
    {:get => "/lines/#{@line}"}.should route_to(:action => "show",
        :id => @line, :controller => "lines")
  end

  it "should expose a hackable URL to a zone's line" do
    {:get => "/zones/#{@zone}/lines/#{@line}"}.should route_to(
        :action => "show", :zone_id => @zone, :id => @line, :controller => "lines")
  end

  it "should expose a direct URL to edit a line" do
    {:get => "/lines/#{@line}/edit"}.should route_to(:action => "edit",
        :id => @line, :controller => "lines")
  end

  it "should expose a hackable URL to edit a zone's line" do
    {:get => "/zones/#{@zone}/lines/#{@line}/edit" }.should route_to(
        :action => "edit", :zone_id => @zone, :id => @line, :controller => "lines")
  end

  it { {:put => "/lines/#{@line}"}.should route_to(:action => "update",
        :id => @line, :controller => "lines") }
end
