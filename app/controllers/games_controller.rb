class GamesController < ApplicationController
  before_filter :find_games, :only => :index
  before_filter :find_game, :only => [:show, :edit, :update]

  respond_to :json, :only => [:index, :show, :create, :update]
  respond_to :html

  def index
    respond_with @games
  end

  def new
    @game = Game.new
    respond_with @game
  end

  def create
    @game = Game.create params[:game]
    respond_with(@game, :location => game_path(@game))
  end

  def show
    respond_with @game
  end

  def edit
    respond_with @game
  end

  def update
    @game.update_attributes! params[:game]
    respond_with(@game, :location => game_path(@game))
  end

  private

  def find_games
    @games = Game.all
  end

  def find_game
    @game = Game.find params[:id]
  end
end
