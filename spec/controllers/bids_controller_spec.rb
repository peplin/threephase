require 'spec_helper'

describe BidsController do
  before :all do
    @model = Bid
    @generator = Factory :auction_generator
  end

  before do
    @generator.bids.delete
  end

  context "as an admin" do
    before :all do
      @state = Factory :state
    end

    before do
      State.stubs(:find_by_game).returns(@state)
      login_as_admin
    end

    context "POST" do
      before :all do
        @data = Factory.attributes_for(:bid, :generator => @generator).update(
            Factory(:bid, :generator => @generator).attributes)
      end

      before do
        Generator.find(@data["generator_id"]).bids.each do |bid|
          bid.delete
        end
      end

      it_should_behave_like "standard successful POST create"

      def redirect_path
        generator_path assigns(:bid).generator
      end
    end
  end

  context "as a player" do
    before :all do
      login
    end

    context "POST for a generator not owned by this user" do
      before do
        @generator.bids.each do |bid|
          bid.delete
        end
        @data = Factory.attributes_for(:bid, :generator => @generator).update(
            Factory(:bid, :generator => @generator).attributes)
        @generator.bids.each do |bid|
          bid.delete
        end
      end

      it_should_behave_like "unauthorized POST create"
    end
  end
end
