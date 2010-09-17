require 'spec_helper'

describe LineTypesController do
  before :each do
    @line_type = LineType.all.first
    @game = Game.all.first
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
    before do
      @data = {:ac => 1,
          :voltage => 1,
          :resistance => 1,
          :diameter => 1,
          :height => 1,
          :name => "Zap",
          :peak_capacity_min => 1,
          :peak_capacity_max => 2,
          :average_capacity => 1,
          :mtbf => 1,
          :mttr => 1,
          :repair_cost => 1,
          :workforce => 1,
          :area => 1,
          :capitol_cost_min => 1,
          :capitol_cost_min => 2,
          :environmental_disruptiveness => 1,
          :waste_disposal_cost_min => 1,
          :waste_disposal_cost_max => 2,
          :noise => 1,
          :lifetime => 1}
    end

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
      @data = {:ac => 42,
          :voltage => 42,
          :resistance => 42,
          :diameter => 42,
          :height => 42,
          :name => "Zap",
          :peak_capacity_min => 42,
          :peak_capacity_max => 82,
          :average_capacity => 42,
          :mtbf => 42,
          :mttr => 42,
          :repair_cost => 42,
          :workforce => 42,
          :area => 42,
          :capitol_cost_min => 42,
          :capitol_cost_min => 2,
          :environmental_disruptiveness => 42,
          :waste_disposal_cost_min => 42,
          :waste_disposal_cost_max => 82,
          :noise => 42,
          :lifetime => 42}
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
