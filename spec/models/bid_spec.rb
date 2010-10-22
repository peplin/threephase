require 'spec_helper'

describe Bid do
  it { should validate_presence_of :price }
  it { should_not validate_presence_of :accepted }
  it { should belong_to :generator }
  it { should validate_presence_of :generator }

  it "should validate that no bid exists for the generator for the last day" do
    generator = Factory :generator
    generator.city.state.game.regulation_type = :auction
    generator.save
    bid = Factory :bid, :generator => generator
    lambda { another_bid = Factory :bid, :generator => bid.generator
        }.should raise_error
  end

  it "should validate that the game has auction-style regulation" do
    generator = Factory :generator
    generator.city.state.game.regulation_type = :ror
    generator.save
    lambda { bid = Factory :bid, :generator => generator }.should raise_error
  end
end
