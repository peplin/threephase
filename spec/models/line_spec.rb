require 'spec_helper'

describe Line do
  it { should belong_to :city }
  it { should belong_to :line_type }

  it { should validate_presence_of :city }
  it { should validate_presence_of :line_type }

  it { should have_many :repairs }

  context "an instance of Line" do
    before :all do
      @line = Factory :line
    end

    it "should validate that the incoming and outgoing states are different" do
      @line.other_city = @line.city
      @line.save.should raise_error
    end
  end
end
