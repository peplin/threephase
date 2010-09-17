require 'spec_helper'

describe UsersController do
  before :each do
    @user = User.all.first
  end

  context "on GET to" do
    context "for HTML" do
      context ":index" do
        before do
          get :index
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:users) }
      end

      context ":new" do
        before do
          get :new
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:user).with_kind_of(User) }
      end

      context ":edit with a user" do
        before do
          get :edit, :id => @user
        end

        it { should respond_with :success }
        it { should render_template :edit }
        it { should assign_to(:user).with(@user) }
      end

      context ":edit" do
        before do
          get :edit
        end

        it { should respond_with :success }
        it { should render_template :edit }
        # TODO how to authenticate this request?
        it { should assign_to(:user).with(@user) }
      end

      context ":show with user" do
        before do
          get :show, :id => @user
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:user).with(@user) }
      end

      context ":show with user" do
        before do
          get :show
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:user).with(@user) }
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
          get :show, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    before do
      #TODO user params?
      @data = {}
    end

    context "for HTML" do
      it "should create a user" do
        proc { post :create, :user => @data }.should change(User, :count).by(1)
        should respond_with :success
        # TODO check that params are saved
      end
    end

    context "for JSON" do
      before do
        post :create, :user => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on PUT to :update" do
    before do
      #TODO user params?
      @data = {}
    end
    context "for HTML" do
      before do
        put :update, :id => @user, :user => @data
      end

      it { should respond_with :success }
      it "should update the generator type" do
        # TODO check that it is updated
      end
    end

    context "for JSON" do
      before do
        put :update, :id => @user, :user => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

end
