require 'spec_helper'

describe "routing to research_advancements" do
  before :all do
    @advancement = Factory(:research_advancement).to_param
  end

  it { {:get => "/advancements"}.should route_to(
      :action => "index", :controller => "research_advancements") }

  it "should expose a direct URL to an advancement" do
    {:get => "/advancements/#{@advancement}"
      }.should route_to(:action => "show", :id => @advancement,
      :controller => "research_advancements")
  end

  it { {:post => "/advancements"}.should route_to(
      :action => "create", :controller => "research_advancements") }

  it { {:post => "/advancements"}.should route_to(:action => "create",
      :controller => "research_advancements") }

  it "does not allow editing of an advancement" do
    {:put => "/advancements/#{@advancement}"}.should_not be_routable
  end

  it "does not allow deleting of an advancement" do
    {:delete => "/advancements/#{@advancement}"}.should_not be_routable
  end
end
