class ZonesController < ApplicationController
  before_filter :find_game, :only => :index
  before_filter :find_zones, :only => :index
  before_filter :find_zone, :only => [:show, :edit]

  respond_to :json, :only => [:index, :show]
  respond_to :html

  def index
    respond_with @zones
  end

  def show
    respond_with @zone
  end

  private

  def find_zones
    if current_user.admin?
      @zones = @game.regions.collect do |r|
        r.zones
      end
    else
      @region = current_user.regions.find_by_game(@game)
      @zones = @region.zones
    end
  end

  def find_zone
    @zone = Zone.find params[:id]
  end
end
