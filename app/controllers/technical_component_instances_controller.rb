class TechnicalComponentInstancesController < ApplicationController
  before_filter :login_required
  before_filter :find_city, :only => [:index, :new]
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
    @instance = component_type.new :city => @city
    respond_with @instance
  end

  def create
    massage_params unless not params[param_symbol]
    @instance = component_type.new params[param_symbol]
    if @instance.save
      flash[:notice] = "#{component_type.to_s} was successfully created."
      respond_with @instance.state
    else
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
    massage_params unless not params[param_symbol]

    if @instance.update_attributes params[param_symbol]
      flash[:notice] = "#{component_type.to_s} was successfully updated."
    end
    respond_with @game, @instance
  end

  private

  def find_city
    if params[:city_id]
      @city = City.find params[:city_id]
    end
  end

  def find_instance
    key = "#{param_symbol}_id"
    if params[key]
      @instance = component_type.find params[key]
    end
  end

  def find_instances
    if @city
      @instances = @city.instances
    else
      if current_user.admin?
        @instances = @game.states
      else
        @state = current_user.states.find_by_game(@game)
        @instances = @state.send(component_type.to_s.underscore.pluralize)
      end
    end
  end

  def find_instance
    @instance = component_type.find params[:id]
  end

  private

  def massage_params
    type_id_key = "#{component_type.name.underscore}_type_id"
    if not params[param_symbol][:buildable_id]
      params[param_symbol][:buildable_id] = params[param_symbol][type_id_key]
      params[param_symbol].delete type_id_key
    end
    if not params[param_symbol][:buildable_type]
      params[param_symbol][:buildable_type] = "#{component_type.name}Type"
    end
  end
  
  def param_symbol
    component_type.name.underscore.to_sym
  end
end
