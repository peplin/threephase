require 'spec_helper'
require 'crud_helper'

describe GamesController do
  before :each do
    @model = 'Game'
    @game = Factory :game
    @generator_type = Factory :generator_type
  end

  def add_generator_type_to_game
    @game.allowed_generator_types << Factory(:allowed_generator_type)
    @game.save!
  end

  def reallow_type
    add_generator_type_to_game
    post_allow @game.allowed_generator_types.first.attributes
  end

  def post_allow type, format='html'
    post :allow, :id => @game, :allowed => type, :format => format
  end

  def delete_disallow id, format='html'
    delete :disallow, :id => @game, :allowed_id => id, :format => format
  end

  def do_get action, format='html'
    get action, :format => format
  end

  context "as an admin" do
    before do
      Factory :admin_user_session
    end

    context "on GET to" do
      context "index" do
        before :all do
          @action = :index
        end

        context "for HTML" do
          share_as :Index do
            before :all do
              get @action
            end

            it { should respond_with :success }
            it { should render_template :index }
            it { should assign_to(:games) }
          end
        end

        context "get JSON", :shared => true do
          before do
            get @action, :format => "json"
          end
          it { should respond_with_content_type :json }
        end
      end

      context "new" do
        before do
          get :new
        end

        share_as :New do
          it { should render_template :new }
          it { assigns(:game).should be_a_new Game }
        end

        it { should respond_with :success }
      end

      context "edit" do
        share_as :Edit do
          before do
            get :edit, :id => @game
          end

          it { should respond_with :success }
          it { should render_template :edit }
          it { should assign_to(:game).with(@game) }
        end

        it { should respond_with :success }
      end

      context "show" do
        before do
          @action = :show
          @params = {:id => @game}
        end

        context "for HTML" do
          share_as :Show do
            context "should render the show template for a valid record" do
              before do
                get :show, :id => @game
              end

              it { should respond_with :success }
              it { should render_template :show }
              it { should assign_to(:game).with(@game) }
            end

            context "should return an error with a missing record" do
              before do
                get :show, :id => 42
              end

              it { should respond_with :missing }
              it { should_not render_template :index }
              it { should_not assign_to :game }
            end
          end
        end

        it_should_behave_like "get JSON"
      end
    end

    context "on POST to :create" do
      before do
        @data = Factory.attributes_for :game
        @action = :create
      end

      context "for HTML" do
        context "with custom parameters" do
          before do
            post :create, :game => @data 
          end

          it "should create a game" do
            proc { post :create, :game => @data 
                }.should change(Game, :count).by(1)
          end
          it { should respond_with :success }
          it { should redirect_to game_path @game }
          it { should set_the_flash } 
        end

        context "without data" do
          before do
            post :create
          end

          it "should create a default game" do
            proc { post :create }.should change(Game, :count).by(1)
          end

          it { should respond_with :success }
          it { should redirect_to game_path @game }
          it { should set_the_flash } 
        end

        context "with invalid data" do
          before do
            post :create, :game => Factory.attributes_for(:invalid_game)
          end

          it "should not create a game" do
            proc { post :create }.should_not change(Game, :count)
          end

          it { should respond_with :bad_request }
          it { should set_the_flash } 
          it_should_behave_like New
        end
      end

      context "for JSON" do
        it "should create a game" do
          should respond_with :success
        end
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
            @game.updated_at.should_not eq(@game.reload.updated_at)
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
            @game.updated_at.should eq(@game.reload.updated_at)
          end
        end
      end

      context "for JSON" do
        before do
          put :update, :id => @game, :game => @data, :format => "json"
        end

        it { should respond_with :success }
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
            allow_type @data
          end

          share_as :TypeAllowed do
            it { @game.allowed_generator_types.should include(@type) }
            it { should redirect_to allowed_types_path @game }
          end
        end

        context "with an existing type" do
          before do
            reallow_type
          end

          it_should_behave_like TypeAllowed
        end
      end

      context "for JSON" do
        before do
          post :allow, :id => @game, :allowed => @data, :format => "json"
        end

        it { should respond_with :success }
      end
    end

    context "on DELETE to :disallow" do
      context "for HTML" do
        context "with an existing allowed type" do
          before do
            add_generator_type_to_game
            disallow_json @allowed
          end

          it { @game.allowed_generator_types.should_not include(@type) }
          it { should redirect_to allowed_types_path @game }
        end

        context "with an already disallowed type" do
          before do
            delete :disallow, :id => @game, :allowed_id => @allowed,
                :format => "json"
          end

          it { should respond_with :missing }
        end
      end

      context "for JSON" do
        before do
          delete :disallow, :id => @game, :allowed_id => @allowed,
              :format => "json"
        end

        it { should respond_with :success }
      end
    end
  end
end
