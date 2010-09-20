require 'spec_helper'

describe "routing to research_advancements" do
  before do
    @game = Factory(:game).to_param
    @advancement = Factory(:research_advancement).to_param
  end

  it { {:get, "/games/#{@game}/advancements"}.should route_to(
      :action => "index", :game_id => @game,
      :controller => "research_advancements") }

  it { {:get, "/games/#{@game}/advancements/#{@advancement}"
      }.should route_to(:action => "show", :game_id => @game,
      :id => @advancement, :controller => "research_advancements") }

  it { {:post, "/games/#{@game}/advancements"}.should route_to(
      :action => "create", :game_id => @game,
      :controller => "research_advancements") }

  it "does not expose a list of all research_advancements" do
    {:get => "/advancements"}.should_not be_routable
  end

  it "does not allow editing of an advancement" do
    {:put => "/advancements/#{@advancement}"}.should_not be_routable
  end

  it "does not allow deleting of an advancement" do
    {:delete => "/advancements/#{@advancement}"}.should_not be_routable
  end
end
