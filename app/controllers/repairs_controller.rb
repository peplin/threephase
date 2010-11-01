class RepairsController < ApplicationController
  before_filter :login_required
  before_filter :game_required
  before_filter :conditional_find_generator, :only => :index
  before_filter :conditional_find_line, :only => :index
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
    elsif current_game
      @state = current_user.states.find_by_game(current_game)
      @repairs = @state.repairs
    end
  end

  def find_repair
    @repair = Repair.find params[:id]
  end
end
