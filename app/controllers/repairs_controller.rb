class RepairsController < ApplicationController
  before_filter :login_required
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
    @game = Game.find params[:game_id]
    # TODO support findng repairs for a specific object
    #@repairs = Repair.find_by_game @game
  end

  def find_repair
    @repair = Repair.find params[:id]
  end
end
