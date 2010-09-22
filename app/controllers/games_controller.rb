class GamesController < ApplicationController
  before_filter :find_games, :only => :index
  before_filter :find_game, :only => [:show, :edit, :update]

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
    if @game.update_attributes params[:game]
      flash[:notice] = 'Game was successfully updated'
    else
      flash[:error] = @game.errors
    end
    respond_with @game
  end

  private

  def find_games
    @games = Game.all
  end

  def find_game
    @game = Game.find params[:id]
  end
end
