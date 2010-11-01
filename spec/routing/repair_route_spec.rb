require 'spec_helper'

describe "routing to repairs" do
  before :all do
    @generator = Factory(:generator).to_param
    @line = Factory(:line).to_param
    @repair = Factory(:repair).to_param
  end

  it "should expose a list of the current game's repairs" do
    {:get => "/repairs"}.should route_to(:action => "index", :controller => "repairs")
  end

  it "should expose a list of a line's repairs in the current game" do
    {:get => "/lines/#{@line}/repairs"}.should route_to(
      :action => "index", :line_id => @line, :controller => "repairs")
  end

  it { {:post => "/repairs"}.should route_to(:action => "create",
      :controller => "repairs") }

  it "should expose a direct URL to a repair" do
    {:get => "/repairs/#{@repair}"}.should route_to(:action => "show",
        :id => @repair, :controller => "repairs")
  end

  it "should expose a hackable URL to a generator's repair in the current game" do
    {:get => "/generators/#{@generator}/repairs/#{@repair}"
        }.should route_to(:action => "show", :generator_id => @generator,
        :id => @repair, :controller => "repairs")
  end

  it "should expose a hackable URL to the current game's repair" do
    {:get => "/repairs/#{@repair}"}.should route_to(
        :action => "show", :id => @repair, :controller => "repairs")
  end

  it "does not allow editing of a repair" do
    {:put => "/repairs/#{@repair}" }.should_not be_routable
  end

  it "does not allow deleting of a repair" do
    {:delete => "/repairs/#{@repair}" }.should_not be_routable
  end
end
