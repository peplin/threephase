require 'spec_helper'

describe Market do
  it { should have_many :market_prices }
  it { should have_many :fuel_types }
  it { should validate_presence_of :name }

  it { should respond_to :friendly_id }

  context "A Market instance" do
    before do
      @market = Market.create :name => "Foo"
    end

    it { @market.friendly_id.should eq(@market.name.downcase) }
  end
end
