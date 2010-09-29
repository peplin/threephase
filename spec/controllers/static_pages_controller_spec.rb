require 'spec_helper'

describe StaticPagesController do
  include CrudSetup

  context "GET to about" do
    before do
      get :about
    end

    it { should respond_with :success }
    it { should render_template :about }
  end

end
