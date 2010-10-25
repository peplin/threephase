class FuelMarketsController < ApplicationController
  before_filter :find_game
  before_filter :find_markets
  respond_to :json, :html

  def index
    respond_with @markets
  end

  def show
    @market = FuelMarket.find params[:id]
    respond_with @fuel_market.current_price @game
  end

  private

  def find_markets
    @markets = FuelMarket.all
  end
end
