require 'spec_helper'

describe InterstateLine do
  it { should belong_to :incoming_region }
  it { should belong_to :outgoing_region }
  it { should belong_to :line_type }
  it { should validate_presence_of :accepted}
end
