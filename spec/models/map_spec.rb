require 'spec_helper'

describe Map do
  it { should belong_to :user }
  it { should have_many :regions }
  it { should have_many :blocks }
  it { should allow_value("Cityville").for(:name) }
  it { should_not allow_value("foobarfoobarfoobarfoobarfoobarfoobarfoobarfoobar").for(:name) }

  it { should respond_to :friendly_id }

  context "A Map instance" do
    before do
      @map = Map.create :name => "Foo"
    end

    it { @map.friendly_id.should eq(@map.name.downcase) }
  end
end
