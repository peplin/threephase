require 'spec_helper'

describe "routing to research_advancements" do
  it { {:get, "/game/1/research_advancements"}.should route_to(:action => :index,
      :game => 1, :controller => "research_advancements") }

  it { {:post, "/game/1/research_advancements"}.should route_to(:action => :create,
      :game => 1, :controller => "research_advancements") }

  it "does not expose a list of all research_advancements" do
    {:get => "/research_advancements"}.should_not be_routable
  end

  it "does not allow editing of a research" do
    {:put => "/generator/1/research/1"}.should_not be_routable
  end

  it "does not allow deleting of a research" do
    {:delete => "/generator/1/research/1"}.should_not be_routable
  end
end
