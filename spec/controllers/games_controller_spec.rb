require 'spec_helper'
require 'crud_helper'


describe GamesController do
  before :all do
    @model = Game
  end

  before :each do
    @game = Factory :game
    @generator_type = Factory :generator_type
  end

  def add_generator_type_to_game
    @game.allowed_generator_types << Factory(:allowed_generator_type)
    @game.save!
  end

  def delete_disallow id, format='html'
    delete :disallow, :id => @game, :allowed_id => id, :format => format
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

    context "on POST to :create without data" do
      before do
        do_post
      end

      it "should create a default game" do
        proc { do_post }.should change(Game, :count).by(1)
      end

      it { should respond_with :success }
      it { should redirect_to game_path @game }
      it { should set_the_flash } 

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
        it "should not create a new game" do
          proc { put :update, :id => @game, :game => @data
              }.should_not change(Game, :count)
        end

        context "when a started game is updated" do
          before do
            put :update, :id => @started_game, :game => @data
          end

          it { should respond_with :bad_request }
          it { should redirect_to game_path @game }
          it { should set_the_flash }
          it "should not update the game" do 
            @game.updated_at.should eq(@game.reload.updated_at)
          end
        end

        context "when a not started game is updated" do
          before do
            put :update, :id => @game, :game => @data
          end

          it { should respond_with :success }
          it { should redirect_to game_path @game }
          it { should set_the_flash }
          it "should update the game" do
            @game.updated_at.should_not eq(@game.reload.updated_at)
          end
        end
      end

      context "for JSON" do
        before do
          put :update, :id => @game, :game => @data, :format => "json"
        end

        share_as :JSONResponse do
          it { should respond_with :success }
          it { should respond_with_content_type :json }
        end
      end
    end

    context "on POST to :allow" do
      before do
        @type = Factory :allowed_generator_type
        @data = @type.attributes
      end

      context "for HTML" do
        context "with a new type" do
          before do
            do_post
          end

          share_as :TypeAllowed do
            it { @game.allowed_generator_types.should include(@type) }
            it { should redirect_to allowed_types_path @game }
          end
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
  end
end
