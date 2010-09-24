require 'spec_helper'

describe InterstateLine do
  it { should belong_to :incoming_region }
  it { should belong_to :outgoing_region }
  it { should belong_to :line_type }

  it { should validate_presence_of :incoming_region }
  it { should validate_presence_of :outgoing_region }
  it { should validate_presence_of :line_type }

  it { should validate_presence_of :operating }
  it { should validate_presence_of :operating_level }

  it { should respond_to :friendly_id }
end
