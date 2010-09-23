require 'spec_helper'

describe "routing to games" do
  before :all do
    @game = Factory(:game).to_param
    @allowed = Factory(:allowed_generator_type).to_param
  end

  it "routes /games to game#index" do
    {:get, "/games"}.should route_to(:action => "index", :controller => "games")
  end

  it "routes /games/new to game#new" do
    {:get, "/games/new"}.should route_to(:action => "new",
        :controller => "games")
  end

  it "routes a post to /games to game#create" do
    {:post, "/games"}.should route_to(:action => "create",
        :controller => "games")
  end

  it "routes /games/:id to game#show for id" do
    {:get, "/games/#{@game}"}.should route_to(:action => "show",
        :id => @game, :controller => "games")
  end

  it "routes /games/:id/edit to game#edit for id" do
    {:get, "/games/#{@game}/edit"}.should route_to(:action => "edit",
        :id => @game, :controller => "games")
  end

  it "routes /games/:id to game#update for id" do
    {:put, "/games/#{@game}"}.should route_to(:action => "update",
        :id => @game, :controller => "games")
  end

  it "does not permit games to be deleted" do
    {:delete, "/games/#{@game}"}.should_not be_routable
  end
end
