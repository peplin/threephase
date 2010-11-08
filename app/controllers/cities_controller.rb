class CitiesController < ApplicationController
  before_filter :find_game, :only => :index
  before_filter :find_cities, :only => :index
  before_filter :find_city, :except => :index

  respond_to :json, :html

  def index
    respond_with @cities
  end

  def show
    respond_with @city
  end

  def load_profile
    respond_with @city.load_profile
  end

  private

  def find_cities
    if params[:state_id]
      @cities = State.find(params[:state_id]).cities
    else
      @cities = current_state.cities
    end
  end

  def find_city
    @city = City.find params[:id]
  end
end
