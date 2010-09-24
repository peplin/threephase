class InterstateLinesController < ApplicationController
  before_filter :login_required
  before_filter :find_region, :only => :index
  before_filter :find_game, :only => :index
  before_filter :find_interstate_lines, :only => :index
  before_filter :find_interstate_line, :only => [:show, :edit, :update]

  respond_to :json, :except => [:new, :edit]
  respond_to :html

  def index
    respond_with @interstate_lines
  end

  def new
    # TODO need a better way to trigger :missing errors for some functions
    @game = Game.find params[:game_id]
    @interstate_line = InterstateLine.new :incoming_region => @region
    respond_with @interstate_line
  end

  def create
    @interstate_line = InterstateLine.new params[:interstate_line]
    if @interstate_line.save
      flash[:notice] = 'Interstate line was successfully created.'
    else
      flash[:error] = @interstate_line.errors
    end
    respond_with @interstate_line
  end

  def show
    respond_with @interstate_line
  end

  def edit
    respond_with @interstate_line
  end

  def update
    # TODO only allow updating response, and only if not set
    if @interstate_line.update_attributes params[:interstate_line]
      flash[:notice] = 'Interstate line was successfully updated'
    else
      flash[:error] = @interstate_line.errors
    end
    respond_with @interstate_line
  end

  private

  def find_region
    if params[:region_id]
      @region = Region.find params[:region_id]
    end
  end

  def find_game
    if params[:game_id]
      @game = Game.find params[:game_id]
    end
  end

  def find_interstate_lines
    if @region
      @interstate_lines = @region.interstate_lines
    elsif @game
      @region = current_user.regions.find_by_game(@game)
      @interstate_lines = @region.interstate_lines
    end
  end

  def find_interstate_line
    @interstate_line = InterstateLine.find params[:id]
  end
end
