class InterstateLinesController < ApplicationController
  before_filter :login_required
  before_filter :conditional_find_region, :only => :index
  before_filter :find_interstate_lines, :only => :index
  before_filter :find_interstate_line, :only => [:show, :edit, :update]

  respond_to :json, :except => [:new, :edit]
  respond_to :html

  def index
    respond_with @interstate_lines
  end

  def new
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
    if @interstate_line.update_attributes params[:interstate_line]
      flash[:notice] = "Response to the interstate line proposal saved."
    else
      flash[:error] = @interstate_line.errors
    end
    respond_with @interstate_line
  end

  private

  def conditional_find_region
    if params[:region_id]
      find_region
    end
  end

  def find_region
    @region = Region.find params[:region_id]
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
