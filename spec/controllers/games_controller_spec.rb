require 'spec_helper'

describe GamesController do
  before :all do
    @model = Game
  end

  before :each do
    @game = Factory :game
    @generator_type = Factory :generator_type
  end

  context "as an admin" do
    before do
      Factory :admin_user_session
    end

    it_should_behave_like "GET index"
    it_should_behave_like "GET show"
    it_should_behave_like "GET edit"
    it_should_behave_like "GET new"
    it_should_behave_like "POST create"
    it_should_behave_like "PUT update"

    context "on POST to :create without data" do
      it_should_behave_like "successful POST create"

      def do_post 
        post :create
      end
    end

    context "on PUT to :update" do
      before do
        @started_game = Factory :started_game
        @data = Factory.attributes_for :huge_game
      end

      context "for HTML" do
        context "when a started game is updated" do
          it_should_behave_like "unsuccessful PUT update"

          def do_put format='html'
            put :update, :id => @started_game, :game => @data
          end
        end

        context "when a not started game is updated" do
          it_should_behave_like "successful PUT update"

          def do_put format='html'
            put :update, :id => @game, :game => @data
          end
        end
      end

      context "for JSON" do
        before do
          put :update, :id => @game, :game => @data, :format => "json"
        end
        it_should_behave_like JSONResponse
      end
    end
  end

  share_examples_for "a user with limited access" do
    it_should_behave_like "GET index"
    it_should_behave_like "GET show"
    it_should_behave_like "unauthorized GET edit"
    it_should_behave_like "unauthorized GET new"
    it_should_behave_like "unauthorized POST create"
    it_should_behave_like "unauthorized PUT update"
  end

  context "as a player" do
    before do
      Factory :user_session
    end
    it_should_behave_like "a user with limited access"
  end

  context "as an anonymous user" do
    it_should_behave_like "a user with limited access"
  end
end
