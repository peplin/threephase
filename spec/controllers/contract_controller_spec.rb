require 'spec_helper'

describe ContractNegotiationController do
  before :each do
    @generator = Generator.all.first
    @offer = Offer.all.first
    @contract = ContractNegotiation.all.first
  end

  context "on GET to" do
    context "for HTML" do
      context ":index with a generator" do
        before do
          get :index, :generator => @generator
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:contracts) }
        it { should assign_to(:generator) }
      end

      context ":index with a game" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:contracts) }
        it { should assign_to(:game) }
        it { should assign_to(:generators) }
      end

      context ":show with a generator" do
        before do
          get :show, :generator => @generator, :contract => @contract
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:contract) }
        it { should assign_to(:generator) }
      end

      context ":show with a game" do
        before do
          get :show, :game => @game, :contract => @contract
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:contract) }
        it { should assign_to(:generator) }
      end

      context ":show with a contract" do
        before do
          get :show, :contract => @contract
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:contract) }
        it { should assign_to(:generator) }
      end

      context ":new" do
      end
    end

    context "for JSON" do
      context ":index with a game" do
        before do
          get :index, :game => @game, :format => "json"
        end

        it { should respond_with_content_type :json }
      end

      context ":show with a contract" do
        before do
          get :show, :contract => @contract, :format => "json"
        end

        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    before do
      #TODO contract params?
      @data = {}
    end
    context "for HTML" do

      it "should create a contract" do
        proc { post :create, :contract => @data }.should change(
            ContractNegotiation, :count)
        should respond_with :success
      end
    end

    context "for JSON" do
      before do
        post :create, :contract => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on POST to :offer" do
    before do
      #TODO contract offer params?
      @data = {}
    end
    context "for HTML" do

      it "should create an offier" do
        proc { post :create, :generator => @generator, :offer => @data
            }.should change(ContractOffer, :count)
        should respond_with :success
      end
    end

    context "for JSON" do
      before do
        post :create, :generator => @generator, :offer => @data,
            :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on PUT to :respond" do
    before do
      #TODO contract offer params?
      @data = {}
    end
    context "for HTML" do
      context "with a generator and contract" do
        it "should update the offer" do
          proc { put :create, :generator => @generator, :contract => @contract,
              :offer => @offer}.should change(ContractOffer, :count)
          should respond_with :success
        end
      end

      context "with a contract" do
        it "should update the offer" do
          proc { put :create, :contract => @contract, :offer => @offer
              }.should change(ContractOffer, :count)
          should respond_with :success
        end
      end

      it "should update the offer" do
        proc { put :create, :offer => @offer }.should change(
            ContractOffer, :count)
        should respond_with :success
      end
    end

    context "for JSON" do
      before do
        put :create, :offer => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
