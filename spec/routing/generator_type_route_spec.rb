require 'spec_helper'

describe "routing to generator types" do
  it { {:get, "/game/1/generators/types"}.should route_to(:action => :index,
        :game => 1, :controller => "generator_types") }

  it { {:get, "/generators/types"}.should route_to(:action => :index,
        :controller => "generator_types") }

  it { {:get, "/generators/types/new"}.should route_to(:action => :new,
      :controller => "generator_types") }

  it { {:post, "/generators/types"}.should route_to(:action => :create,
      :controller => "generator") }

  it { {:get, "/generator/type/1"}.should route_to(:action => :show,
        :id => 1, :controller => "generator_types") }

  it { {:edit, "/generator/type/1"}.should route_to(:action => :show,
        :id => 1, :controller => "generator_types") }

  it { {:put, "/generator/type/1"}.should route_to(:action => :update,
        :id => 1, :controller => "generator_types") }

  it { {:delete, "/generator/type/1"}.should route_to(:action => :delete,
        :id => 1, :controller => "generator_types") }
end
