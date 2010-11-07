class StatesController < ApplicationController
  before_filter :login_required
  before_filter :game_required
  before_filter :find_state, :only => [:show, :edit, :update, :destroy, :prices,
      :curve, :map]

  respond_to :json, :except => [:new, :edit]
  respond_to :html

  def index
    respond_with @states = current_game.states
  end

  def new
    respond_with @state = State.new(:user => current_user, :game => @game)
  end

  def create
    @state = current_user.states.build params[:state]
    # TODO generate a new map
    @state.map = Map.create :name => "foo" unless @state.map
    flash[:notice] = 'State was successfully created.' if @state.save
    respond_with @state
  end

  def destroy
    game = @state.game
    @state.destroy
    redirect_to game
  end

  def switch
    current_state.destroy
    redirect_to new_game_state_path(@game)
  end

  def show
    respond_with @state
  end

  def edit
    respond_with @state
  end

  def update
    if @state.update_attributes params[:state]
      flash[:notice] = 'State was successfully updated'
    end
    respond_with @state
  end

  def prices
    prices = @state.marginal_prices.limit(10)
    (10 - prices.length).times do
      prices << prices.first
    end
    respond_with prices
  end

  def curve
    respond_with({
        :generators => @state.generators.ordered_by_average_cost(@state.game),
        :demand => @state.demand}.to_json)
  end

  def map
    respond_with @state.map, :include => [:blocks]
  end

  private

  def find_state
    @state = State.find params[:id]
  end
end
