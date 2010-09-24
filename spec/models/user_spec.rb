require 'spec_helper'

describe User do
  it { should have_many :maps }
  it { should have_many :regions }
  it { should have_many(:games).through(:regions) }
end
