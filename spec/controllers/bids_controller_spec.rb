require 'spec_helper'

describe BidsController do
  before :each do
    @generator = Generator.all.first
    @bid = Bid.all.first
  end

  context "on GET to" do
    context "for HTML" do
      context ":index with a game" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:bids) }
        it { should assign_to(:generator) }
      end

      context ":index with a game and generator" do
        before do
          get :index, :game => @game, :generator => @generator
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:bids) }
        it { should assign_to(:game) }
        it { should assign_to(:generators) }
      end

      context ":index with invalid parameters" do
        it "should respond with 404 when game is invalid"
        it "should respond with 404 when generator is invalid"
        it "should respond with 404 when both game and generator are invalid"
      end

      context ":show with a game and generator" do
        before do
          get :show, :game => @game, :generator => @generator, :bid => @bid
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:bid) }
        it { should assign_to(:generator) }
      end

      context ":show with a game" do
        before do
          get :show, :game => @game, :bid => @bid
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:bid) }
        it { should assign_to(:generator) }
      end

      context ":show with a bid" do
        before do
          get :show, :bid => @bid
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:bid) }
        it { should assign_to(:generator) }
      end

      context ":show with invalid parameters" do
        it "should respond with 404 when game is invalid"
        it "should respond with 404 when generator is invalid"
        it "should respond with 404 when both game and generator are invalid"
        it "should respond with 404 when bid is invalid"
      end

      context ":show with invalid parameters" do
        it "should respond with 404 when game is invalid"
        it "should respond with 404 when generator is invalid"
        it "should respond with 404 when both game and generator are invalid"
      end

      context ":new" do
        context do
          before do
            get :new, :game => @game, :generator => @generator
          end

          it { should respond_with :success }
          it { should render_template :new }
          it { should assign_to(:bid).with_kind_of(Bid) }
        end

        context "with invalid parameters" do
          it "should respond with 404 when game is invalid"
          it "should respond with 404 when generator is invalid"
          it "should respond with 404 when both game and generator are invalid"
        end
      end

    end

    context "for JSON" do
      context ":index with a game" do
        before do
          get :index, :game => @game, :format => "json"
        end

        it { should respond_with_content_type :json }
      end

      context ":show with a bid" do
        before do
          get :show, :bid => @bid, :format => "json"
        end

        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    before do
      @data = {:generator => @generator, :price => 100}
    end

    context "for HTML" do
      before do
        post :create, :bid => @data
      end

      it { should respond_with :success }
      it { should redirect_to generator_path @generator }

      context "with invalid data" do
        it "should return 400 generator is missing"
        it "should return 400 when price is invalid"
      end

      context "for a generator not owned by this user" do
        it "should return not authorized"
      end
      
      context "when a bid already exists for today" do
        it "should return a 409 conflict"
      end

      context "when the game doesn't have rate of return regulation" do
        it "should return 403 forbidden"
      end
    end

    context "for JSON" do
      before do
        post :create, :bid => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
