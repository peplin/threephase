require 'spec_helper'

describe "routing to interstate_lines" do
  it { {:get, "/game/1/interstate_lines"}.should route_to(:action => :index,
      :game => 1, :controller => "interstate_lines") }

  it { {:get, "/game/1/region/2/interstate_lines"}.should route_to(
      :action => :index, :game => 1, :region => 2,
      :controller => "interstate_lines") }

  it { {:get, "/game/1/interstate_lines/new"}.should route_to(:action => :new,
      :game => 1, :controller => "interstate_lines") }

  it { {:post, "/game/1/interstate_lines"}.should route_to(:action => :create,
      :game => 1, :controller => "interstate_lines") }

  it { {:put, "/game/1/interstate_line/2"}.should route_to(
      :action => :respond, :game => 1, :interstate_line => 2,
      :controller => "interstate_lines") }

  it { {:get, "/game/1/interstate_line/2"}.should route_to(:action => :show,
      :game => 1, :interstate_line => 2, :controller => "interstate_lines") }

  it "does not allow interstate_line deleting" do
    {:delete => "/game/1/interstate_lines/1"}.should_not be_routable
  end
end
