require 'spec_helper'

describe Map do
  it { should belong_to :user }
  it { should allow_value("Cityville").for(:name) }
  it { should_now allow_value("foobarfoobarfoobarfoobarfoobarfoobarfoobarfoobar").for(:name) }
end
