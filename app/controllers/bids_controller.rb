class BidsController < ApplicationController
  before_filter :find_generator, :only => [:index, :new]
  before_filter :find_game, :only => :index
  before_filter :find_bids, :only => :index
  before_filter :find_bid, :only => :show

  respond_to :json, :except => [:new, :edit]
  respond_to :html, :except => [:show]

  def index
    respond_with @bids
  end

  def new
    @bid = Bid.new :generator => @generator
    respond_with @bid
  end

  def create
    @bid = Bid.new params[:bid]
    if @bid.save
      flash[:notice] = 'Bid was successfully created.'
    end
    respond_with @bid do |format|
      format.html { redirect_to generator_path @bid.generator }
    end
  end

  def show
    respond_with @bid
  end

  private

  def find_generator
    if params[:generator_id]
      @generator = Generator.find params[:generator_id]
    end
  end

  def find_bids
    if @generator
      @bids = @generator.bids
    else
      @state = current_user.states.find_by_game(@game)
      @bids = @state.bids
    end
  end

  def find_bid
    @bid = Bid.find params[:id]
  end
end
