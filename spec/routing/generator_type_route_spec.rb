require 'spec_helper'

describe "routing to generator types" do
  before :all do
    @game = Game.all.first
    @type = GeneratorType.all.first
    @allowed = AllowedGeneratorType.all.first
  end

  it { {:get, "/game/#{@game}/allowed"}.should route_to(:action => :index,
      :game => @game, :controller => "allowed_technical_component_types") }

  it { {:post, "/game/#{@game}/allowed"}.should route_to(:action => :create,
      :game => @game, :controller => "allowed_technical_component_types") }

  it { {:delete, "/game/#{@game}/allowed/#{@allowed}"}.should route_to(
      :action => :delete, :game => @game, :id => @allowed,
      :controller => "allowed_technical_component_types") }

  it { {:get, "/generators/types"}.should route_to(:action => :index,
      :controller => "generator_types") }

  it { {:get, "/generators/types/new"}.should route_to(:action => :new,
      :controller => "generator_types") }

  it { {:post, "/generators/types"}.should route_to(:action => :create,
      :controller => "generator_types") }

  it { {:get, "/generator/type/#{@type}"}.should route_to(:action => :show,
      :id => @type, :controller => "generator_types") }

  it { {:get, "/generator/type/#{@type}/edit"}.should route_to(:action => :edit,
      :id => @type, :controller => "generator_types") }

  it { {:put, "/generator/type/#{@type}"}.should route_to(:action => :update,
      :id => @type, :controller => "generator_types") }

  it { {:delete, "/generator/type/#{@type}"}.should route_to(:action => :delete,
      :id => @type, :controller => "generator_types") }
end
