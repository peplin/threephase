require 'spec_helper'

describe LoadProfile do
  it { should belong_to :zone }
  it { should validate_presence_of :zone }
  it { should validate_presence_of :hour }
  it { should validate_presence_of :demand }
end
