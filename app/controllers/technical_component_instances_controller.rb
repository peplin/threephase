class TechnicalComponentInstancesController < ApplicationController
  before_filter :login_required
  before_filter :find_zone, :only => [:index, :new]
  before_filter :find_game, :only => [:index, :new]
  before_filter :find_instances, :only => :index
  before_filter :find_instance, :only => [:edit, :show, :update]

  respond_to :json, :except => [:new, :edit]
  respond_to :html

  def index
    respond_with @instances
  end

  def new
    if not @game
      @game = Game.find params[:game_id]
    end
    @instance = component_type.new :zone => @zone
    respond_with @instance
  end

  def create
    @instance = component_type.new params[:instance]
    if @instance.save
      flash[:notice] = "#{component_type.to_s} was successfully created."
      respond_with @instance.region
    else
      flash[:error] = @instance.errors
      respond_with @instance
    end
  end

  def show
    respond_with @instance
  end

  def edit
    respond_with @instance
  end

  def update
    if @instance.update_attributes params[:instance]
      flash[:notice] = "#{component_type.to_s} was successfully updated."
    else
      flash[:error] = @instance.errors
    end
    respond_with @game, @instance
  end

  private

  def find_zone
    if params[:zone_id]
      @zone = Zone.find params[:zone_id]
    end
  end

  def find_instance
    if params[:instance_id]
      @instance = component_type.find params[:instance_id]
    end
  end

  def find_game
    if params[:game_id]
      @game = Game.find params[:game_id]
    end
  end

  def find_instances
    if @zone
      @instances = @zone.instances
    else
      if current_user.admin?
        # TODO
      else
        @region = current_user.regions.find_by_game(@game)
        @instances = @region.send(component_type.to_s.underscore.pluralize)
      end
    end
  end

  def find_instance
    @instance = component_type.find params[:id]
  end
end
