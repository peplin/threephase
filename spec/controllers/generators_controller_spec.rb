require 'spec_helper'

describe GeneratorsController do
  before :all do
    @model = Generator
    @instance = Factory :generator
  end

  before do
    State.stubs(:find_by_game).returns(@instance.state)
  end

  it_should_behave_like "a technical component instance"

  context "on GET to :costs" do
    include CrudSetup

    before do
      setup_crud_names
      @instance = Factory @factory_name
      login_as_admin
      get :costs, :id => @instance, :format => 'json' 
    end

    it_should_behave_like JSONResponse
    it { should respond_with :success }
    it "should return a list of marginal costs for the last 10 days" do
      json_response.last.should eq(
        @instance.marginal_cost)
    end
  end
end
