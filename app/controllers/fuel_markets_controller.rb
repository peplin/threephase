class FuelMarketsController < ApplicationController
  before_filter :find_game
  before_filter :find_fuel_markets
  respond_to :json, :html

  def index
    respond_with @fuel_markets
  end

  def show
    @fuel_market = FuelMarket.find params[:id]
    respond_with @fuel_market.current_price @game
  end

  private

  def find_fuel_markets
    @fuel_markets = FuelMarket.all
  end
end
