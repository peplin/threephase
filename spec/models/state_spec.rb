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
  it { should validate_presence_of :cash }
  it { should allow_value(1000).for(:research_budget) }
  it { should_not allow_value(-1000).for(:research_budget) }
  it { should allow_value(1000).for(:research_budget) }
  it { should_not allow_value(-1).for(:cash) }

  context "with an instance of State" do
    before :all do
      @state = Factory :state
      @city = Factory :city, :state => @state
      @generator = Factory :generator, :city => @city
      @line = Factory :line, :city => @city
      @storage_device = Factory :storage_device, :city => @city
    end

    it "should return all repairs" do
      repair = Factory :repair, :repairable => @generator
      @state.repairs.should include repair
    end

    it "should return all bids" do
      bid = Factory :bid
      bid.generator.city = @city
      bid.generator.save
      @state.reload
      @state.bids.should include bid
    end

    it "should return all generators" do
      @state.generators.should include @generator
    end

    it "should return all lines" do
      @state.lines.should include @line
    end

    it "should return all storage devices" do
      @state.storage_devices.should include @storage_device
    end

    it "should return free coordinates" do
      x, y = @state.next_free_coordinates
      x.should be > -1
      y.should be > -1
      @state.cities.each do |city|
        next if city == @city or not city.valid?
        city.distance(x, y).should be > State::CITY_BUFFER
      end
    end

    it "should return the nearest city to a pair of coordinates" do
      @state.cities.find_nearest(100, 200)
    end

    it "should be able to step"
  end

  context "when a State is created" do
    before :all do
      @state = Factory :state
    end

    it "should create a few cities" do
      @state.cities.count.should be > 0
    end
  end
end
