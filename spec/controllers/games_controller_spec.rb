require 'spec_helper'

describe GamesController do
  before :all do
    @model = Game
  end

  context "as an admin" do
    before do
      login_as_admin
    end

    it_should_behave_like "standard GET index"
    it_should_behave_like "standard GET show"
    it_should_behave_like "standard GET edit"
    it_should_behave_like "standard GET new"
    it_should_behave_like "standard POST create"
    it_should_behave_like "standard PUT update"

    context "on PUT to :update" do
      before :all do
        @data = Factory.attributes_for :another_game
        @instance = Factory :started_game
      end

      context "when a started game is updated" do
        it_should_behave_like "unsuccessful PUT update"

        def do_put format='html'
          put :update, :id => @instance, :game => @data, :format => format
        end
      end
    end
  end

  context "as a player" do
    before do
      login
    end

    it_should_behave_like "standard GET index"
    it_should_behave_like "standard GET show"
    it_should_behave_like "unauthorized GET edit"
    it_should_behave_like "unauthorized GET new"
    it_should_behave_like "unauthorized POST create"
    it_should_behave_like "unauthorized PUT update"
  end

  context "as an anonymous user" do
    it_should_behave_like "standard GET index"
    it_should_behave_like "standard GET show"
    it_should_behave_like "unauthorized GET edit"
    it_should_behave_like "unauthorized GET new"
    it_should_behave_like "unauthorized POST create"
    it_should_behave_like "unauthorized PUT update"
  end
end
