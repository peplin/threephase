require 'spec_helper'

describe StorageDeviceType do
  it { should have_many :storage_devices }
  it { should have_many :zones }
  it { should validate_presence_of :decay_rate }
  it { should validate_presence_of :efficiency }
end
