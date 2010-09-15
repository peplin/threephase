require 'spec_helper'

describe GameController do
  before :each do
    @game = Game.all.first
    @generator_type = GeneratorType.all.first
    # TODO which parameters can you update?
    @data = {}
  end

  context "on GET to" do
    context "for HTML" do
      context ":index" do
        before do
          get :index
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:games) }
      end

      context ":new" do
        before do
          get :new
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:game).with_kind_of(Game) }
      end

      context ":edit" do
        before do
          get :edit, :id => @game
        end

        it { should respond_with :success }
        it { should render_template :edit }
        it { should assign_to(:game).with(@game) }
      end

      context ":show" do
        context "should render the show template for a valid record" do
          before do
            get :show, :id => @game
          end

          it { should respond_with :success }
          it { should render_template :index }
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

    context "for JSON" do
      context ":index" do
        before do
          get :index, :format => "json"
        end

        it { should respond_with_content_type :json }
      end

      context ":show for first record" do
        before do
          get :show, :id => @game, :format => "json"
        end

        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    context "for HTML" do
      it "should create a game" do
        proc { post :create, :game => @data }.should change(Game, :count).by(1)
        should redirect_to game_path @game
      end
    end

    context "for JSON" do
      it "should create a game" do
        proc { post :create, :format => "json", :game => @data
          }.should change(Game, :count).by(1)
        should respond_with :success
      end
    end
  end

  context "on PUT to :update" do
    context "for HTML" do
      it "should update a game" do
        proc { put :update, :id => @game, :game => @data
            }.should_not change(Game, :count)
        should redirect_to game_path @game
        @game = Game.find @game
      end
    end

    context "for JSON" do
      before do
        put :update, :id => @game, :game => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on PUT to :allow" do
    context "for HTML" do
      it "should create an allowed component for the game" do
        proc { put :allow, :id => @game, :allowed => @generator_type,
            :format => "json" }.should change(
            AllowedTechnicalComponentType, :count).by(1)
        should redirect_to allowed_types_path @game
      end
    end

    context "for JSON" do
      before do
        put :allow, :id => @game, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on DELETE to :disallow" do
    context "for HTML" do
      it "should delete an allowed component for the game" do
        proc { delete :disallow, :id => @game, :allowed => @generator_type,
            :format => "json" }.should change(
            AllowedTechnicalComponentType, :count).by(-1)
        should redirect_to allowed_types_path @game
      end
    end

    context "for JSON" do
      before do
        delete :allow, :id => @game, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
