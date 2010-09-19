require 'spec_helper'

describe LineTypesController do
  before :each do
    @line_type = LineType.all.first
    @game = Game.all.first
    @data = Factory.attributes_for :line_type
  end

  context "on GET to" do
    context "for HTML" do
      context ":index" do
        before do
          get :index
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:line_types) }
      end

      context ":new" do
        before do
          get :new
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:line_type).with_kind_of(LineType) }
      end

      context ":edit" do
        before do
          get :edit, :id => @line_type
        end

        it { should respond_with :success }
        it { should render_template :edit }
        it { should assign_to(:line_type).with(@line_type) }
      end

      context ":show" do
        before do
          get :show, :id => @line_type
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:line_type).with(@line_type) }
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
          get :show, :id => @line_type, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    context "for HTML" do
      it "should create a line_type" do
        proc { post :create, :line_type => @data }.should change(
            LineType, :count).by(1)
        should respond_with :success
      end
    end

    context "for JSON" do
      before do
        post :create, :line_type => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on PUT to :update" do
    context "for HTML" do
      before do
        put :update, :id => @line_type, :line_type => @data
      end

      it { should redirect_to line_type_path @line_type }
      it "should update the generator type" do
        # TODO check that it is updated
      end
    end

    context "for JSON" do
      before do
        put :update, :id => @line_type, :line_type => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on DELETE to :delete" do
    context "for HTML" do
      it "should delete a line_type" do
        proc { delete :delete, :id => @line_type }.should change(
            LineType, :count).by(-1)
        should redirect_to line_types_path
      end
    end

    context "for JSON" do
      it "should delete a line_type" do
        proc { delete :delete, :id => @line_type }.should change(
            LineType, :count).by(-1)
        should respond_with :success
        it { should respond_with_content_type :json }
      end
    end
  end
end
