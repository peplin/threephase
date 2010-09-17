require 'spec_helper'

describe "routing to contracts" do
  before :all do
    @game = Game.all.first
    @generator = Generator.all.first
    @contract = ContractNegotiation.all.first
    @offer = ContractOffer.all.first
  end

  it { {:get, "/game/#{@game}/contracts"}.should route_to(:action => :index,
        :game => @game, :controller => "contracts") }

  it { {:get, "/generator/#{@generator}/contracts"}.should route_to(
      :action => :index, :generator => @generator, :controller => "contracts") }

  it { {:get, "/generator/#{@generator}/contracts/new"}.should route_to(
      :action => :new, :game => @game, :controller => "contracts") }

  it { {:post, "/contracts"}.should route_to(:action => :create,
      :controller => "contracts") }

  it { {:post, "/contracts/#{@contract}"}.should route_to(:action => :offer,
      :contract => @contract, :controller => "contracts") }

  it { {:put, "/offer/#{@offer}"}.should route_to(:action => :respond,
      :offer => @offer, :controller => "contracts") }

  it { {:get, "/generators/#{@generator}/contracts/#{@contract}"
      }.should route_to(:action => :show, :generator => @generator,
      :contract => @contract, :controller => "contracts") }

  it { {:get, "/games/#{@game}/contracts/#{@contract}"}.should route_to(
      :action => :show, :game => @game, :contract => @contract,
      :controller => "contracts") }

  it { {:get, "/contracts/#{@contract}"}.should route_to(:action => :show,
      :contract => @contract, :controller => "contracts") }

  it "does not allow contract updating" do
    {:put => "/contracts/#{@contract}"}.should_not be_routable
  end

  it "does not allow contract deleting" do
    {:delete => "/contracts/#{@contract}"}.should_not be_routable
  end
end
