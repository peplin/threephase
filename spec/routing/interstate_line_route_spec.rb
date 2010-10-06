require 'spec_helper'

describe "routing to interstate_lines" do
  before :all do
    @line = Factory(:interstate_line).to_param
    @region = Factory(:region).to_param
  end

  it "should expose a list of the current game's interstate lines" do
    {:get => "/interstate-lines"
      }.should route_to(:action => "index", :controller => "interstate_lines")
  end

  it "should expose a list of a region's interstate lines" do
    {:get => "/regions/#{@region}/interstate-lines"
      }.should route_to(:action => "index", :region_id => @region,
      :controller => "interstate_lines")
  end

  it "should expose a hackable URL to a form for a new interstate line" do
    {:get => "/regions/#{@region}/interstate-lines/new"
        }.should route_to(:action => "new", :region_id => @region,
        :controller => "interstate_lines")
  end

  it { {:post => "/interstate-lines"}.should route_to(:action => "create",
      :controller => "interstate_lines") }

  it { {:put => "/interstate-lines/#{@line}"}.should route_to(
      :action => "update", :id => @line,
      :controller => "interstate_lines") }

  it "should expose a hackable URL to a region's interstate line" do
    {:get => "/regions/#{@region}/interstate-lines/#{@line}"
        }.should route_to(:action => "show", :region_id => @region, :id => @line,
        :controller => "interstate_lines")
  end

  it "should expose a direct URL to an interstate line" do
    {:get => "/interstate-lines/#{@line}"}.should route_to(:action => "show",
      :id => @line, :controller => "interstate_lines")
  end

  it "does not allow interstate_line deleting" do
    {:delete => "/interstate-lines/#{@line}"}.should_not be_routable
  end
end
