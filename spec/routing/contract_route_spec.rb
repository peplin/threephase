require 'spec_helper'

describe "routing to contracts" do
  before :all do
    @game = Factory(:game).to_param
    @generator = Factory(:generator).to_param
    @contract = Factory(:contract).to_param
    @offer = Factory(:offer).to_param
  end

  it "should expose a list of all contracts for a game" do
    {:get, "/games/#{@game}/contracts"}.should route_to(:action => "index",
        :game_id => @game, :controller => "contracts")
  end

  it "should expose a list of all contracts for a generator" do
    {:get, "/games/#{@game}/generators/#{@generator}/contracts"
        }.should route_to(:action => "index", :game_id => @game,
        :generator_id => @generator, :controller => "contracts")
  end

  it "should expose a form for a new contract for a generator" do
    {:get, "/games/#{@game}/generators/#{@generator}/contracts/new"
        }.should route_to(:action => "new", :game_id => @game,
        :generator_id => @generator, :controller => "contracts")
  end

  it { {:post, "/contracts"}.should route_to(:action => "create",
      :controller => "contracts") }

  it { {:post, "/offers"}.should route_to(:action => "offer",
      :controller => "contracts") }

  it { {:put, "/offers/#{@offer}"}.should route_to(:action => "update",
      :id => @offer, :controller => "contracts") }

  it "should expose a hackable URL to a game's contract" do
    {:get, "/games/#{@game}/contracts/#{@contract}"}.should route_to(
      :action => "show", :game_id => @game, :id => @contract,
      :controller => "contracts")
  end

  it "should expose a hackable URL to a generator's contract" do
    {:get, "/games/#{@game}/generators/#{@generator}/contracts/#{@contract}"
        }.should route_to(:action => "show", :game_id => @game,
        :generator_id => @generator, :id => @contract,
        :controller => "contracts")
  end

  it "should expose a direct URL to a contract" do
    {:get, "/contracts/#{@contract}"}.should route_to(:action => "show",
      :id => @contract, :controller => "contracts")
  end

  it "does not allow contract updating" do
    {:put => "/contracts/#{@contract}"}.should_not be_routable
  end

  it "does not allow contract deleting" do
    {:delete => "/contracts/#{@contract}"}.should_not be_routable
  end
end
