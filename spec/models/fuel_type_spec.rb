require 'spec_helper'

describe FuelType do
  it { should belong_to :market }
  it { should have_many(:market_prices).through(:market) }
  it { should have_many :generator_types }
  it { should have_many(:generators).through(:generator_types) }
  it { should validate_presence_of :name }

  it { should respond_to :friendly_id }

  context "A FuelType instance" do
    before do
      @type = Factory :fuel_type
      @game = Factory :game
    end

    it { @type.friendly_id.should eq(@type.name.downcase) }

    it "should know the instantaneous demand in a game" do
      demand = @game.generators(@type).inject(0) {|demand, gen|
        demand + gen.fuel_burn_rate
      }
      @type.demand(@game).should eq(demand)
    end

    it "should know the average demand for the fuel now in a game" do
      average = @game.generators(@type).inject(0) {|demand, gen|
        demand + gen.average_fuel_burn_rate
      }
      @type.average_demand(@game).should eq(average)
    end

    it "should know the avg demand for the fuel on an arbitrary day in game" do
      average = @game.generators(@type).inject(0) {|demand, gen|
        demand + gen.average_fuel_burn_rate(1.day.ago)
      }
      @type.average_demand(@game, 1.day.ago).should eq(average)
    end
  end
end
