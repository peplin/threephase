class GamesController < ApplicationController
  before_filter :admin_required, :except => [:index, :show]
  before_filter :find_game, :only => [:show, :edit, :update]
  before_filter :find_games, :only => [:index, :show]

  respond_to :json, :except => [:new, :edit]
  respond_to :html

  def index
    respond_with @games
  end

  def new
    @game = Game.new
    respond_with @game
  end

  def create
    @game = Game.new params[:game]
    if @game.save
      flash[:notice] = "Game was successfully created."
    end
    respond_with @game
  end

  def show
    cookies[:current_game] = @game.id
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
      end
      respond_with @game
    end
  end

  private

  def find_game
    if params[:id]
      @game = Game.find params[:id]
    else
      @game = current_game
    end
  end
end
