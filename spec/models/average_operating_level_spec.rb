require 'spec_helper'

describe AverageOperatingLevel do
  it { should belong_to :technical_component_instance }
  it { should validate_presence_of :operating_level }
end
