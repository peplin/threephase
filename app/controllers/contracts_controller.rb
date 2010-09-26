class ContractsController < ApplicationController
  before_filter :find_generator, :only => [:index, :new]
  before_filter :find_game, :only => :index
  before_filter :find_contracts, :only => :index
  before_filter :find_contract, :only => [:show, :new]
  before_filter :find_offer, :only => [:update, :respond]

  respond_to :json, :except => [:new]
  respond_to :html

  def index
    respond_with @contracts
  end

  def new
    @offer = @contract.offers.build
    respond_with @offer
  end

  def show
    respond_with @contract
  end

  def create
    @offer = Offer.new params[:offer]
    if @offer.save
      flash[:notice] = 'Offer was made succesfully on the contract'
    else
      flash[:error] = @offer.errors
    end
    respond_with @offer.contract
  end

  def update
    @offer.update_attributes params[:offer]
    if @offer.save
      flash[:notice] = 'Offer was updated successfuly'
    else
      flash[:error] = @offer.errors
    end
    respond_with @offer.contract
  end

  private

  def find_contracts
    if @generator
      @contracts = @generator.contracts
    else
      @region = current_user.regions.find_by_game(@game)
      @contracts = @region.contracts
    end
  end

  def find_contract
    @contract = Contract.find params[:id]
  end

  def find_offer
    @offer = Offer.find params[:id]
  end
end
