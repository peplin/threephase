class StatesController < ApplicationController
  before_filter :login_required
  before_filter :game_required
  before_filter :find_state, :only => [:show, :edit, :update]

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

  private

  def find_state
    @state = State.find params[:id]
  end
end
