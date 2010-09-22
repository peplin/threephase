class MarketPricesController < ApplicationController
  before_filter :find_zone
  before_filter :find_game
  before_filter :find_markets, :only => :index
  before_filter :find_market, :only => :show

  respond_to :json, :html

  def index
    respond_with @markets
  end

  def show
    # TODO return the prices, not the market
    respond_with @market
  end

  private

  def find_zone
    if params[:zone_id]
      @zone = Zone.find params[:zone_id]
    end
  end

  def find_game
    @game = Game.find params[:game_id]
  end

  def find_markets
    @markets = Market.all
  end

  def find_market
    # TODO if we haev a zone, get the more specific price
    @market = Market.find params[:id]
  end
end
