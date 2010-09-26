class RegionsController < ApplicationController
  before_filter :login_required
  before_filter :find_game, :only => [:index, :new]
  before_filter :find_regions, :only => :index
  before_filter :find_region, :only => [:show, :edit, :update]

  respond_to :json, :except => [:new, :edit]
  respond_to :html

  def index
    respond_with @regions
  end

  def new
    @region = Region.new :user => current_user
    respond_with @region
  end

  def create
    @region = current_user.regions.build params[:region]
    if not @region.map
      # TODO generate a new map
      @region.map = Map.create :name => "foo"
    end
    if @region.save
      flash[:notice] = 'Region was successfully created.'
    else
      flash[:error] = @region.errors
      @game = @region.game
    end
    respond_with @region.game, @region
  end

  def show
    respond_with @region
  end

  def edit
    respond_with @region
  end

  def update
    if @region.update_attributes params[:region]
      flash[:notice] = 'Region was successfully updated'
    else
      flash[:error] = @region.errors
    end
    respond_with @region
  end

  private

  def find_game
    @game = Game.find params[:game_id]
  end

  def find_regions
    @regions = @game.regions
  end

  def find_region
    @region = Region.find params[:id]
    @game = @region.game
  end
end
