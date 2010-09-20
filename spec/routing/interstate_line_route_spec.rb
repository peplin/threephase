require 'spec_helper'

describe "routing to interstate_lines" do
  before do
    @line = Factory(:interstate_line).to_param
    @game = Factory(:game).to_param
    @region = Factory(:region).to_param
  end

  it "should expose a list of a game's interstate lines" do
    {:get, "/games/#{@game}/interstatelines"
      }.should route_to(:action => "index", :game_id => @game,
      :controller => "interstate_lines")
  end

  it "should expose a list of a region's interstate lines" do
    {:get, "/games/#{@game}/regions/#{@region}/interstatelines"
      }.should route_to(:action => "index", :game_id => @game,
      :region_id => @region, :controller => "interstate_lines")
  end

  it "should expose a hackable URL to a form for a new interstate line" do
    {:get, "/games/#{@game}/regions/#{@region}/interstatelines/new"
        }.should route_to(:action => "new", :game_id => @game,
        :region_id => @region, :controller => "interstate_lines")
  end

  it { {:post, "/interstatelines"}.should route_to(:action => "create",
      :controller => "interstate_lines") }

  it { {:put, "/interstatelines/#{@line}"}.should route_to(
      :action => "update", :id => @line,
      :controller => "interstate_lines") }

  it "should expose a hackable URL to a region's interstate line" do
    {:get, "/games/#{@game}/regions/#{@region}/interstatelines/#{@line}"
        }.should route_to(:action => "show", :game_id => @game,
        :region_id => @region, :id => @line, :controller => "interstate_lines")
  end

  it "should expose a direct URL to an interstate line" do
    {:get, "/interstatelines/#{@line}"}.should route_to(:action => "show",
      :id => @line, :controller => "interstate_lines")
  end

  it "does not allow interstate_line deleting" do
    {:delete => "/interstatelines/#{@line}"}.should_not be_routable
  end
end
