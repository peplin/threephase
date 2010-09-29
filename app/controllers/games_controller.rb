class GamesController < ApplicationController
  before_filter :admin_required, :except => [:index, :show]
  before_filter :find_game, :only => [:show, :edit, :update]

  respond_to :json, :except => [:new, :edit]
  respond_to :html

  def index
    @games = Game.all
    respond_with @games
  end

  def new
    @game = Game.new
    respond_with @game
  end

  def create
    @game = Game.new params[:game]
    if @game.save
      flash[:notice] = 'Game was successfully created.'
    else
      flash[:error] = @game.errors
    end
    respond_with @game
  end

  def show
    respond_with @game
  end

  def edit
    respond_with @game
  end

  def update
    if @game.started
        flash[:notice] = "Can't update a game that has already started"
        respond_to do |format|
          format.html { redirect_to game_path @game }
          format.json { head :forbidden }
        end
    else
      if @game.update_attributes params[:game]
        flash[:notice] = 'Game was successfully updated'
      else
        flash[:error] = @game.errors
      end
      respond_with @game
    end
  end

  private
  
  def find_game
    @game = Game.find params[:id]
  end
end
