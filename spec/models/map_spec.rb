require 'spec_helper'

describe Map do
  it { should belong_to :user }
  it { should have_many :regions }
  it { should have_many :blocks }
  it { should allow_value("Cityville").for(:name) }
  it { should_not allow_value("foobarfoobarfoobarfoobarfoobarfoobarfoobarfoobar").for(:name) }
end
