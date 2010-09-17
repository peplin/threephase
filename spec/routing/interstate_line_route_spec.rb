require 'spec_helper'

describe "routing to interstate_lines" do
  before :all do
    @game = Game.all.first
    @line = IntererstateLine.all.first
    @region = Region.all.first
  end

  it { {:get, "/game/#{@game}/interstate_lines"}.should route_to(
      :action => :index, :game => @game, :controller => "interstate_lines") }

  it { {:get, "/game/#{@game}/region/#{@region}/interstate_lines"
      }.should route_to(:action => :index, :game => @game, :region => @region,
      :controller => "interstate_lines") }

  it { {:get, "/game/#{@game}/interstate_lines/new"}.should route_to(
      :action => :new, :game => @game, :controller => "interstate_lines") }

  it { {:post, "/interstate_lines"}.should route_to(:action => :create,
      :controller => "interstate_lines") }

  it { {:put, "/interstate_line/#{@line}"}.should route_to(
      :action => :respond, :interstate_line => @line,
      :controller => "interstate_lines") }

  it { {:get, "/interstate_line/#{@line}"}.should route_to(:action => :show,
      :interstate_line => @line, :controller => "interstate_lines") }

  it "does not allow interstate_line deleting" do
    {:delete => "/interstate_lines/#{@line}"}.should_not be_routable
  end
end
