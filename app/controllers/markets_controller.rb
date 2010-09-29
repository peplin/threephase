class MarketsController < ApplicationController
  respond_to :json, :html

  def index
    @markets = Market.all
    respond_with @markets
  end

  def show
    @market = Market.find params[:id]
    respond_with @market.current_price
  end
end
