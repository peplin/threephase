require 'spec_helper'

describe "routing to generator types" do
  before do
    @game = Factory(:game).to_param
    @type = Factory(:generator_type).to_param
  end

  it { {:get, "/generators/types"}.should route_to(:action => "index",
      :controller => "generator_types") }

  it { {:get, "/generators/types/new"}.should route_to(:action => "new",
      :controller => "generator_types") }

  it { {:post, "/generators/types"}.should route_to(:action => "create",
      :controller => "generator_types") }

  it { {:get, "/generators/types/#{@type}"}.should route_to(:action => "show",
      :id => @type, :controller => "generator_types") }

  it { {:get, "/generators/types/#{@type}/edit"}.should route_to(
      :action => "edit", :id => @type, :controller => "generator_types") }

  it { {:put, "/generators/types/#{@type}"}.should route_to(:action => "update",
      :id => @type, :controller => "generator_types") }

  it { {:delete, "/generators/types/#{@type}"}.should route_to(
      :action => "destroy", :id => @type, :controller => "generator_types") }
end
