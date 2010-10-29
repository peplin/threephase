require 'spec_helper'

describe AverageOperatingLevel do
  it { should belong_to :technical_component_instance }
  it { should validate_presence_of :operating_level }

  context "an instance of AverageOperatingLevel" do
    before do
      @average = Factory :average_operating_level, :operating_level => 42,
          :updated_at => Time.now.beginning_of_day
    end

    it "should refresh with a single refresh this hour" do
      time = @average.updated_at
      Time.stubs(:now).returns(time)
      proc { @average.refresh(62) } .should change(@average,
          :operating_level)
      @average.operating_level.should be > 42
    end

    it "should refresh with multiple hours in between refreshes" do
      time = @average.updated_at + 2.hours
      Time.stubs(:now).returns(time)
      proc { @average.refresh(62) }.should change(@average,
          :operating_level).from(42).to(47)
    end
  end
end
