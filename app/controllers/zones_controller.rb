class ZonesController < ApplicationController
  before_filter :find_zones, :only => :index
  before_filter :find_zone, :only => [:show, :edit, :update]

  respond_to :json, :only => [:index, :show, :create, :update]
  respond_to :html

  def index
    respond_with @zones
  end

  def create
    @zone = Zone.new params[:zone]
    if @zone.save
      flash[:notice] = 'Zone was successfully created.'
    else
      flash[:error] = @zone.errors
    end
    respond_with @zone
  end

  def show
    respond_with @zone
  end

  private

  def find_zones
    @zones = Zone.all
  end

  def find_zone
    @zone = Zone.find params[:id]
  end
end
