require 'spec_helper'

describe InterstateLine do
  it { should belong_to :incoming_region }
  it { should belong_to :outgoing_region }
  it { should belong_to :line_type }

  it { should validate_presence_of :accepted}
  it { should validate_presence_of :operating }
  it { should validate_presence_of :operating_level }

  it { should respond_to :friendly_id }

  context "A InterstateLine instance" do
    before do
      @incoming = Region.all.first
      @outgoing = Region.all[1]
      @line = InterstateLine.create :incoming_region => @incoming,
          :outgoing_region => @outgoing
    end

    it { @line.friendly_id.should eq(
        "#{@incoming.friendly_id}-#{@outgoing.friendly_id}") }
  end
end
