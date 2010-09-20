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

    context "on POST to :allow" do
      before do
        @type = Factory :allowed_generator_type
        @data = @type.attributes
      end

      context "for HTML" do
        share_as :TypeAllowed do
          it { @game.allowed_generator_types.should include(@type) }
          it { should redirect_to allowed_types_path @game }
        end

        context "with a new type" do
          before do
            do_post
          end

          it_should_behave_like TypeAllowed
        end

        context "with an existing type" do
          before do
            add_generator_type_to_game
            do_post @game.allowed_generator_types.first.attributes
          end

          it_should_behave_like TypeAllowed
        end
      end

      context "for JSON" do
        before do
          do_post :format => 'json'
        end
        it_should_behave_like JSONResponse
      end

      def do_post type=nil, format='html'
        type = @data unless type
        post :allow, :game_id => @game, :id => type, :format => format
      end
    end

    context "on DELETE to :disallow" do
      context "for HTML" do
        context "with an existing allowed type" do
          before do
            add_generator_type_to_game
            do_delete
          end

          it { @game.allowed_generator_types.should_not include(@type) }
          it { should redirect_to allowed_types_path @game }
        end

        context "with an already disallowed type" do
          before do
            do_delete
          end

          it { should respond_with :missing }
        end
      end

      context "for JSON" do
        before do
          do_delete 'json'
        end
        it_should_behave_like JSONResponse
      end
    end

    def do_delete format='html'
      delete :disallow, :game_id => @game, :id => @allowed, :format => format
    end

    def add_generator_type_to_game
      @game.allowed_generator_types << Factory(:allowed_generator_type)
      @game.save!
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
