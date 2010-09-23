require 'spec_helper'

describe WindProfile do
  it { should belong_to :block }

  it { should validate_presence_of :block }
  it { should validate_presence_of :hour }
  it { should validate_presence_of :speed }
end
