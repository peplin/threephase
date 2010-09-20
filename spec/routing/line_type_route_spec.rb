require 'spec_helper'

describe "routing to line types" do
  before :all do
    @game = Factory(:game).to_param
    @type = Factory(:line_type).to_param
  end

  it { {:get, "/games/#{@game}/lines/types"}.should route_to(:action => "index",
      :game => @game, :type => LineType,
      :controller => "allowed_technical_components") }

  it { {:post, "/games/#{@game}/lines/types"}.should route_to(:action => "allow",
        :game => @game, :controller => "allowed_technical_components") }

  it { {:delete, "/games/#{@game}/lines/types/#{@type}"}.should route_to(
      :action => "disallow", :game => @game, :type => @type,
      :controller => "allowed_technical_components") }

  it { {:get, "/lines/types"}.should route_to(:action => "index",
        :controller => "line_types") }

  it { {:get, "/lines/types/new"}.should route_to(:action => "new",
      :controller => "line_types") }

  it { {:post, "/lines/types"}.should route_to(:action => "create",
      :controller => "line_types") }

  it { {:get, "/lines/types/#{@type}"}.should route_to(:action => "show",
        :id => @type, :controller => "line_types") }

  it { {:get, "/lines/types/#{@type}/edit"}.should route_to(:action => "edit",
        :id => @type, :controller => "line_types") }

  it { {:put, "/lines/types/#{@type}"}.should route_to(:action => "update",
        :id => @type, :controller => "line_types") }

  it { {:delete, "/lines/types/#{@type}"}.should route_to(:action => "destroy",
        :id => @type, :controller => "line_types") }
end
