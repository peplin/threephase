require 'spec_helper'

describe GeneratorsController do
  before :each do
    @generator = Generator.all.first
    @game = Game.all.first
    @zone = Zone.all.first
    @data = Factory.attributes_for(:generator)
  end

  context "as an admin" do
    context "on GET" do
      context "for HTML to" do
        context ":index with game" do
          before do
            get :index, :game => @game
          end

          it { should respond_with :success }
          it { should render_template :index }
          it { should assign_to(:generators) }
        end

        context ":index with game and zone" do
          before do
            get :index, :game => @game, :zone => @zone
          end

          it { should respond_with :success }
          it { should render_template :index }
          it { should assign_to(:generators) }
        end

        context ":new with a game" do
          before do
            get :new, :game => @game
          end

          it { should respond_with :success }
          it { should render_template :new }
          it { should assign_to(:generator).with_kind_of(Generator) }
        end

        context ":new with a game and zone" do
          before do
            get :new, :game => @game, :zone => @zone
          end

          it { should respond_with :success }
          it { should render_template :new }
          it { should assign_to(:generator).with_kind_of(Generator) }
          it { assigns(:generator).zone.should eq(@zone) }
        end

        context ":edit" do
          before do
            get :edit, :id => @generator
          end

          it { should respond_with :success }
          it { should render_template :edit }
          it { should assign_to(:generator).with(@generator) }
        end

        context ":show" do
          before do
            get :show, :id => @generator
          end

          it { should respond_with :success }
          it { should render_template :show }
          it { should assign_to(:generator).with(@generator) }
        end
      end

      context "for JSON to" do
        context ":index with game" do
          before do
            get :index, :game => @game, :format => "json"
          end

          it { should respond_with :success }
          it { should respond_with_content_type :json }
        end

        context ":show" do
          before do
            get :show, :id => @generator, :format => "json"
          end

          it { should respond_with :success }
          it { should respond_with_content_type :json }
        end
      end
    end

    context "on POST to :create" do
      context "with valid data" do
        context "for HTML" do
          before do
            post :create, :generator => @data
          end

          it "should create a generator" do
            proc { post :create, :generator => @data
                }.should change(Generator, :count).by(1)
          end

          it { should redirect_to region_path @zone.region }
          it { should set_the_flash }
          # TODO check that params are saved
        end

        context "for JSON" do
          before do
            post :create, :generator => @data, :format => "json"
          end

          it { should respond_with :success }
        end
      end

      context "with invalid data" do
        context "for HTML" do
          it "should not create a generator" do
            proc { post :create, :generator => @data
                }.should_not change(Generator, :count)
            should respond_with 400
          end
        end

        context "for JSON" do
          before do
            post :create, :generator => @data, :format => "json"
          end

          it { should respond_with 400 }
        end
      end
    end

    context "on PUT to :update" do
      context "with valid data" do
        context "for HTML" do
          before do
            put :update, :id => @generator, :generator => @data
          end

          it { should redirect_to region_path @zone.region }
          it "should update the generator type" do
            # TODO check that it is updated
          end
        end

        context "for JSON" do
          before do
            put :update, :id => @generator, :generator => @data, :format => "json"
          end

          it { should respond_with :success }
        end
      end

      context "with invalid data" do
        context "for HTML" do
          before do
            put :update, :id => @generator
          end
          
          it { should respond_with 400 }
        end

        context "for JSON" do
          before do
            put :update, :id => @generator, :format => "json"
          end

          it { should respond_with 400 }
        end
      end

      context "for an invalid generator" do
        context "for HTML" do
          before do
            put :update, :id => 42
          end
          
          it { should respond_with :missing }
        end

        context "for JSON" do
          before do
            put :update, :id => 42, :format => "json"
          end

          it { should respond_with :missing }
        end
      end
    end
  end

  context "as an authorized user" do
    it "should allow me to create a generator for my game"
    it "should allow me to update a my generator"
  end
  
  context "as an unauthorized user" do
    it "should not allow me to create a generator for someone else's game"
    it "should not allow me to update someone else's generator"
  end

  context "as an anonymous user" do
    it "should not allow me to create a generator"
  end
end
