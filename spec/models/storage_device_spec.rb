require 'spec_helper'

describe StorageDevice do
  it { should belong_to :zone }
  it { should belong_to :storage_device_type }
  it { should have_many :repairs }
end