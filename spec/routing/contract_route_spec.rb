require 'spec_helper'

describe "routing to contracts" do
  before :all do
    @generator = Factory(:generator).to_param
    @contract = Factory(:contract).to_param
    @offer = Factory(:offer).to_param
  end

  it "should expose a list of all contracts for a game" do
    {:get => "/contracts"}.should route_to(:action => "index",
        :controller => "contracts")
  end

  it "should expose a list of all contracts for a generator" do
    {:get => "/generators/#{@generator}/contracts"}.should route_to(
        :action => "index", :generator_id => @generator, :controller => "contracts")
  end

  it { {:post => "/offers"}.should route_to(:action => "offer",
      :controller => "contracts") }

  it { {:put => "/offers/#{@offer}"}.should route_to(:action => "respond",
      :id => @offer, :controller => "contracts") }

  it "should expose a hackable URL to a generator's contract" do
    {:get => "/generators/#{@generator}/contracts/#{@contract}" }.should route_to(
        :action => "show", :generator_id => @generator, :id => @contract,
        :controller => "contracts")
  end

  it "should expose a direct URL to a contract" do
    {:get => "/contracts/#{@contract}"}.should route_to(:action => "show",
      :id => @contract, :controller => "contracts")
  end

  it "does not allow contract updating" do
    {:put => "/contracts/#{@contract}"}.should_not be_routable
  end

  it "does not allow contract deleting" do
    {:delete => "/contracts/#{@contract}"}.should_not be_routable
  end
end
