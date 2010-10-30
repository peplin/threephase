require 'spec_helper'

describe InterstateLine do
  it { should belong_to :incoming_state }
  it { should belong_to :outgoing_state }
  it { should belong_to :line_type }

  it { should validate_presence_of :incoming_state }
  it { should validate_presence_of :outgoing_state }
  it { should validate_presence_of :line_type }

  context "an instance of InterstateLine" do
    before do
      @line = Factory :interstate_line
    end

    it "should not allow modification of incoming_state" do
      @line.incoming_state = Factory :state
      @line.save!.should raise_error
    end

    it "should not allow modification of outgoing_state" do
      @line.outgoing_state = Factory :state
      @line.save!.should raise_error
    end

    it "should not allow modification of line_type" do
      @line.line_type = Factory :line_type
      @line.save!.should raise_error
    end

    it "should not allow modification of accepted once set" do
      @line.accepted = true
      @line.save!

      lambda { @line.accepted = false }.should raise_error
    end

    it "should validate that the incoming and outgoing states are different" do
      line = Factory.build :interstate_line
      line.incoming_state = @line.incoming_state
      line.outgoing_state = line.incoming_state
      line.save.should raise_error
    end
  end
end
