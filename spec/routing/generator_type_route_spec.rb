require 'spec_helper'

describe "routing to generator types" do
  before :all do
    @game = Factory(:game).to_param
    @type = Factory(:generator_type).to_param
  end

  it { {:get, "/games/#{@game}/generators/types"}.should route_to(:action => "index",
      :game => @game, :type => GeneratorType,
      :controller => "allowed_technical_components") }

  it { {:post, "/games/#{@game}/generators/types"}.should route_to(:action => "allow",
        :game => @game, :controller => "allowed_technical_components") }

  it { {:delete, "/games/#{@game}/generators/types/#{@type}"}.should route_to(
      :action => "disallow", :game => @game, :type => @type,
      :controller => "allowed_technical_components") }

  it { {:get, "/generators/types"}.should route_to(:action => "index",
      :controller => "generator_types") }

  it { {:get, "/generators/types/new"}.should route_to(:action => "new",
      :controller => "generator_types") }

  it { {:post, "/generators/types"}.should route_to(:action => "create",
      :controller => "generator_types") }

  it { {:get, "/generator/types/#{@type}"}.should route_to(:action => "show",
      :id => @type, :controller => "generator_types") }

  it { {:get, "/generator/types/#{@type}/edit"}.should route_to(:action => "edit",
      :id => @type, :controller => "generator_types") }

  it { {:put, "/generator/types/#{@type}"}.should route_to(:action => "update",
      :id => @type, :controller => "generator_types") }

  it { {:delete, "/generator/types/#{@type}"}.should route_to(:action => "destroy",
      :id => @type, :controller => "generator_types") }
end
