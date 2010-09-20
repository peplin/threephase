class GamesController < ApplicationController
  before_filter find_games, :only => :index
  before_filter find_game, :only => [:show, :edit, :update]

  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def find_games
    @games = Game.all
  end

  def find_game
    @game = Game.find params[:id]
  end
end
