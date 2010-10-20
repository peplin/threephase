require 'spec_helper'

describe User do
  it { should have_many :maps }
  it { should have_many :states }
  it { should have_many(:games).through(:states) }

  context "a User instance" do
    before do
      @user = Factory :user
    end

    context "with an existing game" do
      before do
        @state = Factory :state, :user => @user
      end

      it "should know its current game" do
        @user.current_game.should eq(@state.game)
      end

      it "should know its current game state" do
        @user.current_state.should eq(@state)
      end
    end
  end
end
