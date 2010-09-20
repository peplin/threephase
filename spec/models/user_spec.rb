require 'spec_helper'

describe User do
  it { should have_many :maps }
  it { should have_many :regions }
  it { should have_many(:games).through(:regions) }
  it { should validate_presence_of :email }
  it { should allow_value("test@example.com").for(:email) }
  it { should_not allow_value("test").for(:email) }
end
