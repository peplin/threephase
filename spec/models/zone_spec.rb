require 'spec_helper'

describe Zone do
  it { should belong_to :region }
  it { should have_many :blips }
  it { should have_many :load_profiles }
  it { should have_many :generators }
  it { should have_many :lines }
  it { should have_many :storage_devices }
  it { should have_db_index [:x, :y] }
  it { should validate_presence_of :name }
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }

  it { should respond_to :friendly_id }

  context "A Zone instance" do
    setup do
      @zone = Zone.create :name => "Foo"
    end

    it "should know its current demand" do
      assert @zone.demand
    end

    it { @zone.friendly_id.should eq(@zone.name.downcase) }
  end
end
