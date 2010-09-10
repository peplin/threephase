require 'spec_helper'

describe "routing to line types" do
  it { {:get, "/game/1/lines/types"}.should route_to(:action => :index,
        :game => 1, :controller => "line_types") }

  it { {:get, "/lines/types"}.should route_to(:action => :index,
        :controller => "line_types") }

  it { {:get, "/lines/types/new"}.should route_to(:action => :new,
      :controller => "line_types") }

  it { {:post, "/lines/types"}.should route_to(:action => :create,
      :controller => "line_types") }

  it { {:get, "/lines/type/1"}.should route_to(:action => :show,
        :id => 1, :controller => "line_types") }

  it { {:edit, "/lines/type/1"}.should route_to(:action => :show,
        :id => 1, :controller => "line_types") }

  it { {:put, "/lines/type/1"}.should route_to(:action => :update,
        :id => 1, :controller => "line_types") }

  it { {:delete, "/lines/type/1"}.should route_to(:action => :delete,
        :id => 1, :controller => "line_types") }
end
