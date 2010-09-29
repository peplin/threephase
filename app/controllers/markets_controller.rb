class MarketsController < ApplicationController
  before_filter :find_game
  respond_to :json, :html

  def index
    @markets = Market.all
    respond_with @markets
  end

  def show
    @market = Market.find params[:id]
    respond_with @market.current_price @game
  end
end
