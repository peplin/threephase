require 'spec_helper'

describe Map do
  it { should belong_to :user }
  it { should have_many :states }
  it { should have_many :blocks }
  it { should allow_value("Cityville").for(:name) }
  it { should_not allow_value("foobarfoobarfoobarfoobarfoobarfoobarfoobarfoobar").for(:name) }

  it { should respond_to :friendly_id }

  context "A Map instance" do
    before do
      @map = Map.create :name => "Foo"
    end

    it { @map.friendly_id.should eq(@map.name.downcase) }

    it "should have a height" do 
      @map.height.should be >= 0
    end

    it "should have a width" do
      @map.width.should be >= 0
    end
  end
end
