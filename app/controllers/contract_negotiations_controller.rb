class ContractNegotiationsController < ApplicationController
  before_filter :find_generator, :only => [:index, :new]
  before_filter :find_game, :only => :index
  before_filter :find_contracts, :only => :index
  before_filter :find_contract, :only => [:show]
  before_filter :find_offer, :only => [:update, :respond]

  respond_to :json, :except => [:new]
  respond_to :html

  def index
    respond_with @contracts
  end

  def new
    @game = Game.find params[:game_id]
    @contract = ContractNegotiation.new :generator => @generator
    respond_with @contract
  end

  def create
    @contract = ContractNegotiation.new params[:contract]
    if @contract.save
      flash[:notice] = 'ContractNegotiation was successfully created.'
    else
      flash[:error] = @contract.errors
    end
    respond_with @contract
  end

  def show
    respond_with @contract
  end

  def offer
    @offer = ContractOffer.new params[:contract_offer]
    if @offer.save
      flash[:notice] = 'Offer was made succesfully on the contract'
    else
      flash[:error] = @offer.errors
    end
    respond_with @offer.contract_negotiation
  end

  def update
    @offer.update_attributes params[:contract_offer]
    if @offer.save
      flash[:notice] = 'Offer was updated successfuly'
    else
      flash[:error] = @offer.errors
    end
    respond_with @offer.contract_negotiation
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
    @contract = ContractNegotiation.find params[:id]
  end

  def find_offer
    @offer = ContractOffer.find params[:id]
  end
end
