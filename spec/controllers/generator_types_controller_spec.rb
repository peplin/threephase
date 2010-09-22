require 'spec_helper'

describe GeneratorTypesController do
  before :all do
    @model = GeneratorType
  end

  before :each do
    @generator_type = Factory :generator_type
    @data = Factory.attributes_for :generator_type
  end

  context "as an admin" do
    before do
      Factory :admin_user_session
    end

    it_should_behave_like "standard GET index"
    it_should_behave_like "standard GET show"
    it_should_behave_like "standard GET edit"
    it_should_behave_like "standard GET new"
    it_should_behave_like "standard POST create"
    it_should_behave_like "standard PUT update"
    it_should_behave_like "standard DELETE destroy"
  end
end
