require 'spec_helper'

describe LoadProfile do
  it { should belong_to :city }
  it { should validate_presence_of :city }
  it { should validate_presence_of :hour }
  it { should validate_presence_of :demand }

  context "A LoadProfile instance" do
    before do
      @load_profile = Factory :load_profile, :hour => 14
    end

    it "should have a demand" do
      @load_profile.demand.should be > 0
    end

    it "should have higher load if during the day" do
      @day = Factory :load_profile, :hour => 13
      @night = Factory :load_profile, :hour => 3
      @day.demand.should be > @night.demand
    end
  end
end
