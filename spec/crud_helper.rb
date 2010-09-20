module CrudSetup
  def setup_crud_names
    # set up the variables we'll refer to in all specs below.
    # If we had an AssetsController, these would map to:
    # @model_name                    => 'Asset'
    # @model                   => Asset
    # @model_symbol                  => :Asset
    # @pluralized_model_name         => 'Assets'
    # @assigns_model_name            => :asset
    # @pluralized_assigns_model_name => :assets
    @model_name                    = @model.to_s
    @model_symbol                  = @model_name.to_sym
    @pluralized_model_name         = @model_name.humanize.pluralize
    @assigns_model_name            = @model_name.underscore.to_sym
    @pluralized_assigns_model_name = @model_name.underscore.pluralize.to_sym
  end
end

share_as :JSONResponse do
  include CrudSetup

  before do
    setup_crud_names
  end

  it { should respond_with :success }
  it { should respond_with_content_type :json }
end

share_examples_for "GET index" do
  include CrudSetup

  before do
    setup_crud_names
    @template = :index
  end

  context "for HTML" do
    before do
      do_get
    end

    it "should find all #{@pluralized_model_name}" do
      @model.should_receive(:find).with(:all)
    end

    it { should respond_with :success }
    it { should render_template @template }

    it "should assign the #{@pluralized_model_name} view variable" do
      should assign_to(@pluralized_assigns_model_name)
    end
  end

  context "for JSON" do
    before do
      do_get 'json'
    end

    it "should respond with JSON" do
      it { should respond_with_content_type :json }
    end
  end

  def do_get format='html'
    get :index, :format => format
  end
end

share_examples_for "unauthorized GET index" do
  context "for HTML" do
    before do
      do_get
    end

    it { should redirect_to login_path }
  end

  context "for JSON" do
    before do
      do_get 'json'
    end

    it { should respond_with :unauthorized }
  end

  def do_get format='html'
    get :index, :format => format
  end
end

share_examples_for "GET show" do
  include CrudSetup

  before do
    setup_crud_names
    @template = :show
  end

  context "with a valid ID" do
    before do
      @instance = Factory @assigns_model_name
      do_get
    end

    it { should respond_with :success }
    it { should render_template @template }

    it "should find the correct #{@model_name}" do
      @model.should_receive(:find).with(
          @instance.to_param).and_return(@instance)
      do_get
    end

    it { should assign_to(@assigns_model_name).with(@instance) }

    it "should render the correct JSON when requesting JSON" do
      @model.any_instance.expects(:to_json).returns('JSON')
      do_get 'json'
      @response.body.should == 'JSON'
    end

    def do_get format = 'html'
      get 'show', :id => @instance, :format => format
    end
  end

  context "with an invalid ID" do
    before do
      do_get
    end

    it { should respond_with :missing }
    it { should_not render_template @template }
    it { should assign_to(@assigns_model_name) }

    it "should send a 404 if not found via JSON" do
      do_get 'json'
      should respond_with :missing
    end

    def do_get format = 'html'
      get 'show', :id => -1, :format => format
    end
  end

end

share_examples_for "unauthorized GET show" do
  before do
    @instance = Factory @assigns_model_name
  end

  context "for HTML" do
    before do
      do_get
    end

    it { should redirect_to login_path }
  end

  context "for JSON" do
    before do
      do_get 'json'
    end

    it { should respond_with :unauthorized }
  end

  def do_get format = 'html'
    get 'show', :id => @instance, :format => format
  end
end

share_examples_for "POST create" do
  include CrudSetup

  before do
    setup_crud_names
  end

  context "with valid params" do
    it_should_behave_like "successful POST create"

    def do_post format = 'html'
      post 'create', @assigns_model_name => @params, :format => format
    end
  end

  context "with invalid parameters" do
    it_should_behave_like "unsuccessful POST create"

    def do_post format = 'html'
      post 'create',
          @assigns_model_name => Factory.attributes_for(@assigns_model_name),
          :format => format
    end
  end
end

share_examples_for "unauthorized POST create" do
  include CrudSetup

  before do
    setup_crud_names
    do_post
  end

  it { should redirect_to login_path }

  def do_post format = 'html'
    post 'create', @assigns_model_name => @params, :format => format
  end
end

share_examples_for "successful POST create" do
  include CrudSetup

  before do
    setup_crud_names
    @params = Factory.attributes_for(@assigns_model_name, :id => 1)
    @model.any_instance.stubs(:to_param).returns(1)
    do_post
  end

  it { should set_the_flash }

  it "should redirect to the new #{@model_name}'s show page" do
    should redirect_to eval("#{@model_name}_path 1")
  end

  it "should return .to_json when requesting JSON" do
    @model.any_instance.expects(:to_json).returns('JSON')
    do_post 'json'
    @response.body.should == "JSON"
  end

  it "should create a #{@model_name}" do
    proc { do_post }.should change(@model, :count).by(1)
  end
end

share_examples_for "unsuccessful POST create" do
  include CrudSetup

  before do
    setup_crud_names
    do_post
  end

  it { should respond_with :bad_request }
  it { should set_the_flash }
  it { should render_template :new }
  it { assigns(@assigns_model_name).should be_a_new @model }
end


share_examples_for "PUT update" do
  include CrudSetup

  context "with valid parameters" do
    it_should_behave_like "successful PUT update"

    def do_put format = 'html'
      put 'update', :id => @instance, @assigns_model_name => @data,
          :format => format
    end
  end

  context "with invalid parameters" do
    it_should_behave_like "unsuccessful PUT update"

    def do_put format = 'html'
      put 'update', :id => @instance, :format => format
    end
  end
end

share_examples_for "unauthorized PUT update" do
  include CrudSetup

  before do
    setup_crud_names
    do_put
  end

  it { should redirect_to login_path }

  def do_put format = 'html'
    put 'update', :id => @instance, :format => format
  end
end

share_examples_for "successful PUT update" do
  include CrudSetup

  before do
    setup_crud_names
    @instance = Factory @assigns_model_name
    @data = Factory.attributes_for @assigns_model_name
    do_put
  end

  it { should respond_with :success }
  it { should set_the_flash }
  it "should redirect to the updated #{@model_name}'s show page" do
    should redirect_to eval("#{@model_name}_path 1")
  end
  it "should update the #{@model_name}" do
    @instance.updated_at.should_not eq(@instance.reload.updated_at)
  end

  it "should accept JSON" do
    do_put 'json'
    it_should_behave_like JSONResponse
  end
end

share_examples_for "unsuccessful PUT update" do
  include CrudSetup

  before do
    setup_crud_names
    @instance = Factory @assigns_model_name
    do_put
  end

  it { should respond_with :bad_request }
  it { should set_the_flash }
  it "should redirect to the updated #{@model_name}'s edit page" do
    should redirect_to eval("#{@model_name}_path 1")
  end
  it "should not update the #{@model_name}" do
    @instance.updated_at.should eq(@instance.reload.updated_at)
  end
end


share_examples_for "DELETE destroy" do
  include CrudSetup

  before do
    setup_crud_names
  end

  context "with a valid id" do

    before do
      @stubbed_model.stub!(:destroy).and_return(true)
      @model.stub!(:find).and_return(@stubbed_model)
    end

    it "should find the correct #{@model_name}" do
      @model.should_receive(:find).with(@stubbed_model.id.to_s).and_return(@stubbed_model)
      do_delete
    end

    it "should destroy the #{@model_name}" do
      @stubbed_model.should_receive(:destroy).and_return(true)
      do_delete
    end

    it "should redirect to #{@model_name} index when requesting HTML" do
      do_delete
      @response.should redirect_to("/admin/#{@pluralized_assigns_model_name}")
    end

    it "should render 200 when requesting JSON" do
      do_delete 'json'
      @response.headers["Status"].should == "200 OK"
    end

    def do_delete format = 'html'
      delete 'destroy', :id => @stubbed_model.id, :format => format
    end
  end

  context "with an invalid ID" do

    before do
      @model.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
    end

    it "should redirect to #{@model_name} index when requesting HTML" do
      do_delete
      @response.should redirect_to("/admin/#{@pluralized_assigns_model_name}")
    end

    it "should render a 404 when requesting JSON" do
      do_delete 'json'
      @response.headers["Status"].should == "404 Not Found"
    end

    def do_delete format = 'html'
      delete 'destroy', :id => -1, :format => format
    end
  end
end

share_examples_for "GET edit" do
  include CrudSetup

  before do
    setup_crud_names
    @template = :edit
  end

  context "with a valid ID" do
    before do
      @instance = Factory @assigns_model_name
      do_get
    end

    it "should find the #{@model_name}" do
      @model.expects(:find).with(@instance.to_param).returns(@instance)
      do_get
    end

    it { should respond_with :success }
    it { should render_template :edit }
    it { should assign_to(@assigns_model_name).with(@sinstance) }

    def do_get format = 'html'
      get 'edit', :id => @instance, :format => format
    end
  end

  context "with an invalid ID" do
    before do
      do_get
    end

    it { should respond_with :missing }
    it { should_not render_template @template }
    it { should_not assign_to(@assigns_model_name) }

    def do_get format = 'html'
      get 'edit', :id => -1, :format => format
    end
  end
end

share_examples_for "unauthorized GET edit" do
  include CrudSetup

  before do
    @instance = Factory @assigns_model_name
    setup_crud_names
  end

  before do
    do_get
  end

  it { should redirect_to login_path }

  def do_get format = 'html'
    get 'edit', :id => @instance, :format => format
  end
end

share_examples_for "GET new" do
  include CrudSetup

  before do
    setup_crud_names
    @template = :new
    do_get
  end

  it { should respond_with :success }
  it { should render_template :new }
  it { assigns(@assigns_model_name).should be_a_new @model }

  def do_get format = 'html'
    get 'new', :format => format
  end
end

share_examples_for "unauthorized GET new" do
  before do
    do_get
  end

  it { should redirect_to login_path }

  def do_get format = 'html'
    get 'new', :format => format
  end
end
