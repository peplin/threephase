require 'spec_helper'

describe "routing to games" do
  it "routes /games to game#index" do
    {:get, "/games"}.should route_to(:action => :index, :controller => "games")
  end

  it "routes /games/new to game#new" do
    {:get, "/game/new"}.should route_to(:action => :new, :controller => "games")
  end

  it "routes a post to /games to game#create" do
    {:post, "/games"}.should route_to(:action => :create,
        :controller => "games")
  end

  it "routes /game/:id to game#show for id" do
    {:get, "/game/1"}.should route_to(:action => :show, :id => 1,
        :controller => "games")
  end

  it "routes /game/:id to game#show for id" do
    {:edit, "/game/1"}.should route_to(:action => :show, :id => 1,
        :controller => "games")
  end

  it "routes /game/:id to game#update for id" do
    {:put, "/game/1"}.should route_to(:action => :update, :id => 1,
        :controller => "games")
  end

  it "does not permit games to be deleted" do
    {:delete, "/game/1"}.should_not be_routable
  end
end
