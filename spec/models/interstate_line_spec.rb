require 'spec_helper'

describe InterstateLine do
  it { should belong_to :proposing_region }
  it { should belong_to :receiving_region }
  it { should belong_to :line_type }
  it { should validate_presence_of :accepted}
end
