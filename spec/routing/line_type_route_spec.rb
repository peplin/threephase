require 'spec_helper'

describe "routing to line types" do
  before :all do
    @game = Game.all.first
    @type = LineType.all.first
  end

  it { {:get, "/lines/types"}.should route_to(:action => :index,
        :controller => "line_types") }

  it { {:get, "/lines/types/new"}.should route_to(:action => :new,
      :controller => "line_types") }

  it { {:post, "/lines/types"}.should route_to(:action => :create,
      :controller => "line_types") }

  it { {:get, "/lines/type/#{@type}"}.should route_to(:action => :show,
        :id => @type, :controller => "line_types") }

  it { {:get, "/lines/type/#{@type}/edit"}.should route_to(:action => :edit,
        :id => @type, :controller => "line_types") }

  it { {:put, "/lines/type/#{@type}"}.should route_to(:action => :update,
        :id => @type, :controller => "line_types") }

  it { {:delete, "/lines/type/#{@type}"}.should route_to(:action => :delete,
        :id => @type, :controller => "line_types") }
end
