require 'spec_helper'

describe "routing to contracts" do
  before :all do
    @game = Game.all.first
    @generator = Generator.all.first
    @contract = ContractNegotiation.all.first
    @offer = ContractOffer.all.first
  end

  it "should expose a list of all contracts for a game" do
    {:get, "/games/#{@game}/contracts"}.should route_to(:action => :index,
        :game => @game, :controller => "contracts")
  end

  it "should expose a list of all contracts for a generator" do
    {:get, "/generator/#{@generator}/contracts"}.should route_to(
      :action => :index, :generator => @generator, :controller => "contracts")
  end

  it "should expose a form for a new contract for a generator" do
    {:get, "/generator/#{@generator}/contracts/new"}.should route_to(
      :action => :new, :game => @game, :controller => "contracts")
  end

  it { {:post, "/contracts"}.should route_to(:action => :create,
      :controller => "contracts") }

  it { {:post, "/contracts/#{@contract}"}.should route_to(:action => :offer,
      :contract => @contract, :controller => "contracts") }

  it { {:put, "/offer/#{@offer}"}.should route_to(:action => :respond,
      :offer => @offer, :controller => "contracts") }

  it "should expose a hackable URL to a generator's contract" do
    {:get, "/generators/#{@generator}/contracts/#{@contract}" }.should route_to(
        :action => :show, :generator => @generator, :contract => @contract,
        :controller => "contracts")
  end

  it "should expose a hackable URL to a game's contract" do
    {:get, "/games/#{@game}/contracts/#{@contract}"}.should route_to(
      :action => :show, :game => @game, :contract => @contract,
      :controller => "contracts")
  end

  it "should expose a direct URL to a contract" do
    {:get, "/contracts/#{@contract}"}.should route_to(:action => :show,
      :contract => @contract, :controller => "contracts")
  end

  it "does not allow contract updating" do
    {:put => "/contracts/#{@contract}"}.should_not be_routable
  end

  it "does not allow contract deleting" do
    {:delete => "/contracts/#{@contract}"}.should_not be_routable
  end
end
