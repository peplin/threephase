require 'spec_helper'

describe State do
  it { should belong_to :map }
  it { should belong_to :game }
  it { should belong_to :user }
  it { should validate_presence_of :map }
  it { should validate_presence_of :game }
  it { should validate_presence_of :user }
  it { should have_many :research_advancements }
  it { should have_many :incoming_interstate_lines }
  it { should have_many :outgoing_interstate_lines }
  it { should validate_presence_of :name }
  it { should validate_presence_of :research_budget }
  it { should allow_value(1000).for(:research_budget) }
  it { should_not allow_value(-1000).for(:research_budget) }

  context "with an instance of State" do
    before :all do
      @state = Factory :state
      @zone = Factory :zone, :state => @state
      @generator = Factory :generator, :zone => @zone
    end

    it "should return all repairs" do
      repair = Factory :repair, :repairable => @generator
      @state.repairs.should include repair
    end

    it "should return all bids" do
      bid = Factory :bid, :generator => @generator
      @state.bids.should include bid
    end

    it "should return all contracts" do
      contract = Factory :contract, :generator => @generator
      @state.contracts.should include contract
    end

    it "should return free coordinates" do
      x, y = @state.next_free_coordinates
      x.should be > -1
      y.should be > -1
      @state.zones.each do |zone|
        next if zone == @zone or not zone.valid?
        zone.distance(x, y).should be > State::ZONE_BUFFER
      end
    end

    it "should return the nearest zone to a pair of coordinates" do
      @state.zones.find_nearest(100, 200)
    end

  end

  context "when a State is created" do
    before :all do
      @state = Factory :state
    end

    it "should create a few zones" do
      @state.zones.count.should be > 0
    end
  end
end
