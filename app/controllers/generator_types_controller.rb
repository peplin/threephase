class GeneratorTypesController < ApplicationController
  before_filter :find_generator_types, :only => :index
  before_filter :find_generator_type, :only => [:edit, :show, :update, :destroy]

  respond_to :json, :except => [:new, :edit]
  respond_to :html

  def index
    respond_with @generator_types
  end

  def new
    @generator_type = GeneratorType.new
    respond_with @generator_type
  end

  def create
    @generator_type = GeneratorType.new params[:generator_type]
    if @generator_type.save
      flash[:notice] = 'Generator type was successfully created.'
    else
      flash[:error] = @generator_type.errors
    end
    respond_with @generator_type
  end

  def show
    respond_with @generator_type
  end

  def edit
    respond_with @generator_type
  end

  def destroy
    if @generator_type.delete
      flash[:notice] = 'Generator type destroyed'
    else
      flash[:error] = @generator_type.errors
    end
    respond_with @generator_type
  end

  def update
    if @generator_type.update_attributes params[:generator_type]
      flash[:notice] = 'Generator type was successfully updated'
    else
      flash[:error] = @generator_type.errors
    end
    respond_with @generator_type
  end

  private

  def find_generator_types
    @generator_types = GeneratorType.all
  end

  def find_generator_type
    @generator_type = GeneratorType.find params[:id]
  end
end
