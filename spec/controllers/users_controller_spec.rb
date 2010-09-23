require 'spec_helper'

describe UsersController do
  before :all do
    @model = User
  end

  before :each do
    @user = Factory :user
  end

  context "as an admin" do
    it_should_behave_like "standard GET index"
  end
  #TODO lots of work here
end
