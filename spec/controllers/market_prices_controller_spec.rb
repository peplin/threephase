require 'spec_helper'

describe MarketPricesController do
  before :each do
    @game = Factory :game
    @market = Factory :market
    @zone = Factory :zone
  end

  context "on GET to" do
    context "for HTML" do
      context ":index with a game" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:market_prices) }
      end

      context ":index with a game and zone" do
        before do
          get :index, :game => @game, :zone => @zone
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:market_prices) }
      end

      context ":show with a game" do
        before do
          get :show, :game => @game, :id => @market
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:market_price).with(@market) }
      end

      context ":show with a zone" do
        before do
          get :show, :game => @game, :zone => @zone, :id => @market
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:market_price).with(@market) }
      end
    end

    context "for JSON" do
      context ":index" do
        before do
          get :index, :game => @game, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end

      context ":show" do
        before do
          get :show, :game => @game, :id => @market, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end
end
