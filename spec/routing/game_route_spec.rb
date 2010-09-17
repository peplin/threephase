require 'spec_helper'

describe "routing to games" do
  before :all do
    @game = Game.all.first
    @allowed = AllowedGeneratorType.all.first
  end

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
    {:get, "/game/#{@game}"}.should route_to(:action => :show, :id => @game,
        :controller => "games")
  end

  it "routes /game/:id/edit to game#edit for id" do
    {:get, "/game/#{@game}/edit"}.should route_to(:action => :show, :id => @game,
        :controller => "games")
  end

  it "routes /game/:id to game#update for id" do
    {:put, "/game/#{@game}"}.should route_to(:action => :update, :id => @game,
        :controller => "games")
  end

  it "routes /game/:id/allowed to game#allowed" do
    {:get, "/game/#{@game}/allowed"}.should route_to(:action => :allowed, :id => @game,
        :controller => "games")
  end

  it "routes /game/:id/allowed/:allowed_id to game#allow" do
    {:post, "/game/#{@game}/allowed"}.should route_to(:action => :allow,
        :id => @game, :controller => "games")
  end
  it "routes /game/:id/allowed/:allowed_id to game#disaallow" do
    {:delete, "/game/#{@game}/allowed/#{@allowed}"}.should route_to(
        :action => :disallow, :id => @game, :allowed_id => @allowed,
        :controller => "games")
  end

  it "does not permit games to be deleted" do
    {:delete, "/game/#{@game}"}.should_not be_routable
  end
end
