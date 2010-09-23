class ResearchAdvancementsController < ApplicationController
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
    @game = Game.find params[:game_id]
    #TODO need a helper method
    #@region = Region.find_by_game_and_user @game, current_user
    #@research_advancements = ResearchAdvancement.find_by_region @region
  end

  def find_research_advancement
    @research_advancement = ResearchAdvancement.find params[:id]
  end
end
