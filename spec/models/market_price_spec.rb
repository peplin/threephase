require 'spec_helper'

describe MarketPrice do
  it { should belong_to :game }
  it { should belong_to :fuel_market }
  it { should validate_presence_of :game }
  it { should validate_presence_of :fuel_market }
  it { should validate_presence_of :price }

  context "A MarketPrice instance" do
    it "should find the price closest to a time" do
      price = Factory :market_price, :created_at => 6.hours.ago
      another_price = Factory :market_price, :created_at => 12.hours.ago
      MarketPrice.closest_to(7.hours.ago).first.should eq(price)
      MarketPrice.closest_to(12.hours.ago).first.should eq(another_price)
    end
  end
end
