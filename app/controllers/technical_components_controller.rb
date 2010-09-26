class TechnicalComponentsController < ApplicationController
  before_filter :find_types, :only => :index
  before_filter :find_type, :only => [:edit, :show, :update, :destroy]

  respond_to :json, :except => [:new, :edit]
  respond_to :html

  def index
    respond_with @types
  end

  def new
    @type = component_type.new
    respond_with @type
  end

  def create
    @type = component_type.new params[:type]
    if @type.save
      flash[:notice] = "#{component_type.to_s} was successfully created."
    else
      flash[:error] = @type.errors
    end
    respond_with @type
  end

  def show
    respond_with @type
  end

  def edit
    respond_with @type
  end

  def destroy
    @type.delete
    flash[:notice] = "#{component_type.to_s} destroyed."
    respond_to do |format|
      format.html { redirect_to destroy_redirect_path }
      format.json { head :accepted }
    end
  end

  def update
    if @type.update_attributes params[:type]
      flash[:notice] = "#{component_type.to_s} was successfully updated."
    else
      flash[:error] = @type.errors
    end
    respond_with @type
  end

  private

  def find_types
    @types = component_type.all
  end

  def find_type
    @type = component_type.find params[:id]
  end
end
