require 'spec_helper'

describe User do
  it { should have_many :maps }
  it { should have_many :regions }
  it { should have_many(:games).through(:regions) }
  it { should validate_presence_of :email }
  it { should allow_value("test@example.com").for(:email) }
  it { should_not allow_value("test").for(:email) }

  it { should respond_to :friendly_id }

  context "A User instance" do
    before do
      @user = User.create :nickname => "Foo"
    end

    it { @user.friendly_id.should eq(@user.nickname.downcase) }
  end
end
