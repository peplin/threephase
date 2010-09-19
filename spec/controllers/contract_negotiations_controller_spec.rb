require 'spec_helper'

describe ContractNegotiationsController do
  before :each do
    @generator = Factory :generator
    @offer = Factory :offer
    @contract = Factory :contract
  end

  context "on GET to" do
    context "for HTML" do
      context ":index" do
        context "with a game" do
          before do
            get :index, :game => @game
          end

          it { should respond_with :success }
          it { should render_template :index }
          it { should assign_to(:contracts) }
          it { should assign_to(:generator) }
        end

        context "with a game and generator" do
          before do
            get :index, :game => @game, :generator => @generator
          end

          it { should respond_with :success }
          it { should render_template :index }
          it { should assign_to(:contracts) }
          it { should assign_to(:game) }
          it { should assign_to(:generators) }
        end

        context "with invalid parameters" do
          it "should respond with 404"
        end

        context "with unauthorized objects" do
          it "should not allow access if user isn't in the game"
          it "should not allow access if user doesn't own the generator"
        end
      end

      context ":show" do
        context do
          before do
            get :show, :contract => @contract
          end

          it { should respond_with :success }
          it { should render_template :show }
          it { should assign_to(:contract) }
          it { should assign_to(:generator) }
        end

        context "with a game" do
          before do
            get :show, :game => @game, :contract => @contract
          end

          it { should respond_with :success }
          it { should render_template :show }
          it { should assign_to(:contract) }
          it { should assign_to(:generator) }
        end

        context "with a game and a generator" do
          before do
            get :show, :game => @game, :generator => @generator,
                :contract => @contract
          end

          it { should respond_with :success }
          it { should render_template :show }
          it { should assign_to(:contract) }
          it { should assign_to(:generator) }
        end

        context "with invalid parameters" do
          it "should respond with 404"
        end
      end

      context ":new" do
        context do
          before do
            get :new, :game => @game, :generator => @generator
          end

          it { should respond_with :success }
          it { should render_template :new }
          it { assigns(:contract).should be_a_new(ContractNegotiation) }
        end

        context "with invalid parameters" do
          it "should respond with 404"
        end
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

  context "on POST" do
    before do
      @data =  Factory.attributes_for :contract_negotiation
    end

    context "to :create" do
      context "for HTML" do
        it "should create a contract" do
          proc { post :create, :contract => @data }.should change(
              ContractNegotiation, :count)
          should respond_with :success
          should redirect_to generator_contract_path @generator, @contract
        end

        context "with invalid data" do
          it "should respond with 400"
        end
      end

      context "for JSON" do
        before do
          post :create, :contract => @data, :format => "json"
        end

        it { should respond_with :success }
      end
    end

    context "to :offer" do
      before do
        @data = Factory.attributes_for :contract_offer
      end

      context "for HTML" do
        it "should create an offer" do
          proc { post :create, :id => @contract, :offer => @data
              }.should change(ContractOffer, :count)
          should respond_with :success
          should redirect_to generator_contract_path @generator, @contract
        end

        context "with invalid data" do
          it "should respond with 400"
        end
      end

      context "for JSON" do
        before do
          post :create, :id => @contract, :offer => @data, :format => "json"
        end

        it { should respond_with :success }
      end
    end
  end

  context "on PUT to :respond" do
    before do
      @data = Factory.attributes_for :accepted_offer
    end

    context "for HTML" do
      it "should update the offer" do
        proc { put :respond, :id => @offer, :offer => @data
            }.should change(ContractOffer, :count)
        should respond_with :success
        should redirect_to generator_contract_path @generator, @contract
      end
    end

    context "for JSON" do
      before do
        put :respond, :id => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
