class RepairsController < ApplicationController
  before_filter :login_required
  before_filter :find_game, :only => :index
  before_filter :find_generator, :only => :index
  before_filter :find_line, :only => :index
  before_filter :find_storage_device, :only => :index
  before_filter :find_repairs, :only => :index
  before_filter :find_repair, :only => :show

  respond_to :json, :html

  def index
    respond_with @repairs
  end

  def show
    respond_with @repair
  end

  private

  def find_repairs
    if @generator
      @repairs = @generator.repairs
    elsif @line
      @repairs = @line.repairs
    elsif @storage_device
      @repairs = @storage_device.repairs
    elsif @game
      @region = current_user.regions.find_by_game(@game)
      @repairs = @region.repairs
    end
  end

  def find_repair
    @repair = Repair.find params[:id]
  end
end
