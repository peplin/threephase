class CitiesController < ApplicationController
  before_filter :find_game, :only => :index
  before_filter :find_cities, :only => :index
  before_filter :find_city, :only => [:show, :edit]

  respond_to :json, :only => [:index, :show]
  respond_to :html

  def index
    respond_with @cities
  end

  def show
    respond_with @city
  end

  private

  def find_cities
    if current_user.admin?
      @cities = @game.states.collect do |r|
        r.cities
      end
    else
      @state = current_user.states.find_by_game(@game)
      @cities = @state.cities
    end
  end

  def find_city
    @city = City.find params[:id]
  end
end
