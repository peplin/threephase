require 'spec_helper'

describe "routing to research_advancements" do
  before :all do
    @game = Game.all.first
    @advancement = ResearchAdvancement.all.first
  end

  it { {:get, "/games/#{@game}/research-advancements"}.should route_to(
      :action => :index, :game => @game,
      :controller => "research_advancements") }

  it { {:get, "/games/#{@game}/research-advancements/#{@advancement}"
      }.should route_to(:action => :show, :game => @game, :id => @advancement,
      :controller => "research_advancements") }

  it { {:post, "/games/#{@game}/research-advancements"}.should route_to(
      :action => :create, :game => @game,
      :controller => "research_advancements") }

  it "does not expose a list of all research_advancements" do
    {:get => "/research-advancements"}.should_not be_routable
  end

  it "does not allow editing of a research" do
    {:put => "/research/#{@advancement}"}.should_not be_routable
  end

  it "does not allow deleting of a research" do
    {:delete => "/research/#{@advancement}"}.should_not be_routable
  end
end
