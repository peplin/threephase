require 'spec_helper'

describe StorageDeviceTypesController do
  before :each do
    @storage_device_type = StorageDeviceType.all.first
    @game = Game.all.first
    @data = Factory.attributes_for :storage_device_type
  end

  context "on GET to" do
    context "for HTML" do
      context ":index" do
        before do
          get :index
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:storage_device_types) }
      end

      context ":new" do
        before do
          get :new
        end

        it { should respond_with :success }
        it { should render_template :new }
        it do 
          should assign_to(:storage_device_type).with_kind_of(StorageDeviceType)
        end
      end

      context ":edit" do
        before do
          get :edit, :id => @storage_device_type
        end

        it { should respond_with :success }
        it { should render_template :edit }
        it { should assign_to(:storage_device_type).with(@storage_device_type) }
      end

      context ":show" do
        before do
          get :show, :id => @storage_device_type
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:storage_device_type).with(@storage_device_type) }
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
          get :show, :id => @storage_device_type, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    context "for HTML" do
      it "should create a storage_device_type" do
        proc { post :create, :storage_device_type => @data }.should change(
            StorageDeviceType, :count).by(1)
        should respond_with :success
      end
    end

    context "for JSON" do
      before do
        post :create, :storage_device_type => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on PUT to :update" do
    context "for HTML" do
      before do
        put :create, :id => @storage_device_type, :storage_device_type => @data
      end

      it { should redirect_to storage_device_type_path @storage_device_type }
      it "should update the generator type" do
        # TODO check that it is updated
      end
    end

    context "for JSON" do
      before do
        put :create, :id => @storage_device_type, :storage_device_type => @data,
            :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on DELETE to :delete" do
    context "for HTML" do
      it "should delete a storage_device_type" do
        proc { delete :delete, :id => @storage_device_type }.should change(
            StorageDeviceType, :count).by(-1)
        should redirect_to generator_types_path
      end
    end

    context "for JSON" do
      it "should delete a storage_device_type" do
        proc { delete :delete, :id => @storage_device_type }.should change(
            StorageDeviceType, :count).by(-1)
        should respond_with :success
        it { should respond_with_content_type :json }
      end
    end
  end
end
