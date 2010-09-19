require 'spec_helper'

describe StorageDevicesController do
  before :each do
    @storage_device = StorageDevice.all.first
    @game = Game.all.first
    @zone = Zone.all.first
    @data = Factory.attributes_for :storage_device
  end

  context "on GET to" do
    context "for HTML" do
      context ":index with game" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:storage_devices) }
      end

      context ":index with game and zone" do
        before do
          get :index, :game => @game, :zone => @zone
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:storage_devices) }
      end

      context ":new with a game" do
        before do
          get :new, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:storage_device).with_kind_of(StorageDevice) }
      end

      context ":new with a game and zone" do
        before do
          get :new, :game => @game, :zone => @zone
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:storage_device).with_kind_of(StorageDevice) }
        it { assigns(:storage_device).zone.should eq(@zone) }
      end

      context ":edit" do
        before do
          get :edit, :id => @storage_device
        end

        it { should respond_with :success }
        it { should render_template :edit }
        it { should assign_to(:storage_device).with(@storage_device) }
      end

      context ":show" do
        before do
          get :show, :id => @storage_device
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:storage_device).with(@storage_device) }
      end
    end

    context "for JSON" do
      context ":index with game" do
        before do
          get :index, :game => @game, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end

      context ":show" do
        before do
          get :show, :id => @storage_device, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    context "for HTML" do
      it "should create a storage_device" do
        proc { post :create, :storage_device => @data
            }.should change(StorageDevice, :count).by(1)
        should redirect_to region_path @zone.region
        # TODO check that params are saved
      end
    end

    context "for JSON" do
      before do
        post :create, :storage_device => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on PUT to :update" do
    context "for HTML" do
      before do
        put :update, :id => @storage_device, :storage_device => @data
      end

      it { should redirect_to region_path @zone.region }
      it "should update the storage_device type" do
        # TODO check that it is updated
      end
    end

    context "for JSON" do
      before do
        put :update, :id => @storage_device, :storage_device => @data,
            :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
