require 'spec_helper'

describe UsersController do
  before :all do
    @model = User
  end

  context "as an admin" do
    before do
      login_as_admin
    end

    it_should_behave_like "standard GET index"
    it_should_behave_like "standard GET show"
  end

  context "as a player" do
    before do
      login
    end

    it_should_behave_like "unauthorized GET index"
    it_should_behave_like "unauthorized GET show"
  end

  context "as an anonymous user" do
    it_should_behave_like "unauthorized GET index"
    it_should_behave_like "unauthorized GET show"
  end
end
