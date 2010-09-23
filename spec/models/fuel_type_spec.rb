require 'spec_helper'

describe FuelType do
  it { should belong_to :market }
  it { should have_many(:market_prices).through(:market) }
  it { should have_many :generator_types }
  it { should validate_presence_of :name }
  it { should validate_presence_of :market }

  it { should respond_to :friendly_id }

  context "A FuelType instance" do
    before do
      @market = Market.all.first
      @type = FuelType.create :name => "Foo", :market => @market
    end

    it { @type.friendly_id.should eq(@type.name.downcase) }
  end
end
