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

    context "average operating level" do
      before do
        stub_time
      end

      it "should have an average operating level for the day" do
        day = Time.now
        returned_level = @instance.average_operating_level
        level = @instance.average_operating_levels.find(:all,
            :conditions => {
              :created_at => day.at_beginning_of_day..day.end_of_day}).first
        returned_level.should eq(level.operating_level)
      end

      it "should have an average operating level for an arbitrary day" do
        day = 1.day.ago
        level = @instance.average_operating_levels.first
        level.created_at = day
        level.save

        returned_level = @instance.average_operating_level(day)
        level = @instance.average_operating_levels.find_by_day(day)
        returned_level.should eq(level.operating_level)
      end

      it "should have an average operating level dependent only on day" do
        time = Time.now
        @instance.average_operating_level(
            time.at_beginning_of_day).should eq(
            @instance.average_operating_level(time.end_of_day))
      end
    end

    it "should be able to step"
  end
end
