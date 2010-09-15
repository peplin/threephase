require 'spec_helper'

describe BidController do
  before :each do
    @generator = Generator.all.first
    @bid = Bid.all.first
  end

  context "on GET to" do
    context "for HTML" do
      context ":index with a generator" do
        before do
          get :index, :generator => @generator
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:bids) }
        it { should assign_to(:generator) }
      end

      context ":index with a game" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:bids) }
        it { should assign_to(:game) }
        it { should assign_to(:generators) }
      end

      context ":show with a generator" do
        before do
          get :show, :generator => @generator, :bid => @bid
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

      context ":new" do
        before do
          get :new
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:bid).with_kind_of(Bid) }
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
      #TODO bid params?
      @data = {}
    end
    context "for HTML" do
      before do
        post :create, :bid => @data
      end

      it { should respond_with :success }
    end

    context "for JSON" do
      before do
        post :create, :bid => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
