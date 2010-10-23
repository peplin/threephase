class BidsController < ApplicationController
  before_filter :find_bid, :only => :show

  respond_to :json
  respond_to :html, :except => [:show]

  def create
    @bid = Bid.new params[:bid]
    if @bid.generator_id
      return if not check_ownership(
          current_user == Generator.find(@bid.generator_id).state.user)
    end
    if @bid.save
      flash[:notice] = "Bid was successfully created."
    end
    respond_with @bid do |format|
      format.html {
        if @bid.generator
          redirect_to generator_path @bid.generator
        else
          render 'new'
        end
      }
    end
  end

  def show
    respond_with @bid
  end

  private

  def find_bid
    @bid = Bid.find params[:id]
  end
end
