require 'spec_helper'

describe StorageDevice do
  it { should belong_to :city }
  it { should belong_to :storage_device_type }
  it { should validate_presence_of :city }
  it { should validate_presence_of :storage_device_type }
  it { should have_many :repairs }
end
