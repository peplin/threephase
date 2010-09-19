require 'spec_helper'

describe GeneratorTypesController do
  before :each do
    @generator_type = GeneratorType.all.first
    @data = Factory.attributes_for :generator_type
  end

  context "on GET to" do
    context "for HTML" do
      context ":index" do
        before do
          get :index
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:generator_types) }
      end

      context ":show" do
        before do
          get :show, :id => @generator_type
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:generator_type).with(@generator_type) }
      end

      context ":new" do
        before do
          get :new
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:generator_type).with_kind_of(GeneratorType) }
      end

      context ":edit" do
        before do
          get :edit, :id => @generator_type
        end

        it { should respond_with :success }
        it { should render_template :edit }
        it { should assign_to(:generator_type).with(@generator_type) }
      end
    end

    context "for JSON" do
      context ":index" do
        before do
          get :index, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end

      context ":show" do
        before do
          get :show, :id => @generator_type, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    context "for HTML" do
      it "should create a generator_type" do
        proc { post :create, :generator_type => @data }.should change(
            GeneratorType, :count).by(1)
      end
      
      context "when created" do
        before do
          post :create, :generator_type => @data
        end

        it { should redirect_to generator_type_path @generator_type }
      end
    end

    context "for JSON" do
      before do
        post :create, :generator_type => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on PUT to :update" do
    before do
    end

    context "for HTML" do
      before do
        put :update, :id => @generator_type, :generator_type => @data
      end

      it { should redirect_to generator_type_path @generator_type }
      it "should update the generator type" do
        # TODO check that it is updated
        # TODO permission check
      end
    end

    context "for JSON" do
      before do
        put :update, :id => @generator_type, :generator_type => @data,
            :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on DELETE to :delete" do
    context "for HTML" do
      it "should delete a generator_type" do
        proc { delete :delete, :id => @generator_type }.should change(
            GeneratorType, :count).by(-1)
        should redirect_to generator_types_path
      end
    end

    context "for JSON" do
      it "should delete a generator_type" do
        proc { delete :delete, :id => @generator_type }.should change(
            GeneratorType, :count).by(-1)
        should respond_with :success
      end
    end
  end
end
