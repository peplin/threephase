require 'spec_helper'

describe GeneratorTypesController do
  before :each do
    @generator_type = GeneratorType.all.first
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
    before do
      @data = {:safety_mtbf => 1,
          :safety_incident_severity => 1,
          :ramping_speed => 1,
          :fuel_efficiency => 1,
          :air_emissions => 1,
          :water_emissions => 1,
          :maintenance_cost_min => 1,
          :maintenance_cost_max => 2,
          :tax_credit => 1,
          :name => "Cat Dog",
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
      @data = {:safety_mtbf => 42,
          :safety_incident_severity => 42,
          :ramping_speed => 42,
          :fuel_efficiency => 42,
          :air_emissions => 42,
          :water_emissions => 42,
          :maintenance_cost_min => 42,
          :maintenance_cost_max => 84,
          :tax_credit => 42,
          :name => "Cat Dog",
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
