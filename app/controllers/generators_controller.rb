class GeneratorsController < ApplicationController
  before_filter :find_zone, :only => [:index, :new]
  before_filter :find_game, :only => :index
  before_filter :find_generators, :only => :index
  before_filter :find_generator, :only => [:edit, :show, :update]

  respond_to :json, :except => [:new, :edit]
  respond_to :html

  def index
    respond_with @generators
  end

  def new
    @generator = Generator.new :generator => @generator
    respond_with @generator
  end

  def create
    @generator = Generator.new params[:generator]
    if @generator.save
      flash[:notice] = 'Generator was successfully created.'
    else
      flash[:error] = @generator.errors
    end
    respond_with @generator
  end

  def show
    respond_with @generator
  end

  def edit
    respond_with @generator
  end

  def update
    if @generator.update_attributes params[:generator]
      flash[:notice] = 'Generator was successfully updated'
    else
      flash[:error] = @generator.errors
    end
    respond_with @generator
  end

  private

  def find_zone
    if params[:zone_id]
      @zone = Zone.find params[:zone_id]
    end
  end

  def find_generator
    if params[:generator_id]
      @generator = Generator.find params[:generator_id]
    end
  end

  def find_game
    if params[:game_id]
      @game = Game.find params[:game_id]
    end
  end

  def find_generators
    if @zone
      @generators = @zone.generators
    else
      # TODO this should load generator's from the user's region in the game,
      # unless we are an admin
      #@generators = @game.generators
    end
  end

  def find_generator
    @generator = Generator.find params[:id]
  end
end
