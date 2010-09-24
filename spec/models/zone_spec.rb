require 'spec_helper'

describe Zone do
  it { should belong_to :region }
  it { should have_many :blips }
  it { should have_many :load_profiles }
  it { should have_many :generators }
  it { should have_many :lines }
  it { should have_many :storage_devices }
  it { should have_db_index [:x, :y, :region_id] }

  it { should validate_presence_of :region }

  it { should validate_presence_of :name }
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }

  it { should respond_to :friendly_id }

  context "A Zone instance" do
    before do
      @zone = Factory :zone
    end

    it "should know its current demand" do
      @zone.should respond_to(:demand)
    end

    it "should have a positive demand" do
      pending  "not really, but I want to make sure this method is written"
      @zone.demand.should be > 0
    end
  end
end
