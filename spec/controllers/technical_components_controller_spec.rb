require 'spec_helper'

share_examples_for "a technical component type" do
  before :all do
    @assigns_model_name = :type
    @pluralized_assigns_model_name = :types
  end

  context "as an admin" do
    before :all do
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
