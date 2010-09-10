require 'spec_helper'

describe "routing to games" do
  it "routes /games to game#index" do
    {:get, "/games"}.should route_to(:action => :index)
  end

  it "routes /games/new to game#new" do
    {:get, "/game/new"}.should route_to(:action => :new)
  end

  it "routes a post to /games to game#create" do
    {:post, "/games"}.should route_to(:action => :create)
  end

  it "routes /game/:id to game#show for id" do
    {:get, "/game/1"}.should route_to(:action => :show, :id => 1)
  end

  it "routes /game/:id to game#show for id" do
    {:edit, "/game/1"}.should route_to(:action => :show, :id => 1)
  end

  it "routes /game/:id to game#update for id" do
    {:put, "/game/1"}.should route_to(:action => :update, :id => 1)
  end
end
