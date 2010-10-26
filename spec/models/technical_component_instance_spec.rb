require 'spec_helper'

describe TechnicalComponentInstance do
  it { should belong_to :city }
  it { should belong_to :buildable }

  it { should validate_presence_of :city }
  it { should validate_presence_of :operating_level }

  context "instance" do
    before do
      @instance = Factory :generator
    end

    it "should have a shortcut to state" do
      @instance.state.should eq @instance.city.state
    end

    it "should calculate the number of operated hours" do
      stub_time
      @instance.operated_hours(Time.now).should eq(0)
      @instance.operated_hours(1.hour.ago).should be > 0
    end

    it "should be able to step"
  end
end
