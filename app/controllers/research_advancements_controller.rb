class ResearchAdvancementsController < ApplicationController
  before_filter :find_game, :only => :index
  before_filter :find_research_advancements, :only => :index
  before_filter :find_research_advancement, :only => :show

  respond_to :json, :html

  def index
    respond_with @research_advancements
  end

  def show
    respond_with @research_advancement
  end

  private

  def find_research_advancements
    @state = current_user.states.find_by_game(@game)
    @research_advancements = @state.research_advancements
  end

  def find_research_advancement
    @research_advancement = ResearchAdvancement.find params[:id]
  end
end
