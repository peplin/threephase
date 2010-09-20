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

  def subject
    # This is to fix a bug in Shoulda - get undefined attributes without it
    @controller
  end
end

share_as :JSONResponse do
  include CrudSetup

  before do
    setup_crud_names
  end

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

    it { should respond_with :success }
    it { should render_template @template }

    it "should assign a collection view variable" do
      should assign_to(@pluralized_assigns_model_name)
    end
  end

  context "for JSON" do
    before do
      do_get 'json'
    end

    it { should respond_with :success }
    it_should_behave_like JSONResponse
  end

  def do_get format='html'
    get :index, :format => format
  end
end

share_examples_for "unauthorized GET index" do
  include CrudSetup

  context "for HTML" do
    before do
      do_get
    end

    it { should redirect_to login_users_path }
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

    it { should assign_to(@assigns_model_name).with(@instance) }

    context "should accept JSON" do
      before do
        do_get 'json'
      end
      it_should_behave_like JSONResponse
      it { should respond_with :success }
    end

    def do_get format='html'
      get 'show', :id => @instance, :format => format
    end
  end

  context "with an invalid ID" do
    before do
      do_get
    end

    it { should respond_with :missing }
    it { should_not render_template @template }
    it { should_not assign_to(@assigns_model_name) }

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
  include CrudSetup

  before do
    @instance = Factory @assigns_model_name
  end

  context "for HTML" do
    before do
      do_get
    end

    it { should redirect_to login_users_path }
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

share_examples_for "unauthorized POST create" do
  include CrudSetup

  before do
    setup_crud_names
    do_post
  end

  it { should redirect_to login_users_path }

  def do_post format = 'html'
    post 'create', @assigns_model_name => @params, :format => format
  end
end

share_examples_for "successful POST create" do
  include CrudSetup

  before do
    setup_crud_names
    @params = Factory.attributes_for(@assigns_model_name)
    do_post
  end

  it { should set_the_flash }

  it "should redirect to the new instance's show page" do
    @id = assigns(@assigns_model_name).id
    should redirect_to eval("#{@model_name.underscore}_path @id")
  end

  context "should accept JSON" do
    before do
      do_post 'json'
    end
    it_should_behave_like JSONResponse
    it { should respond_with :created }
  end

  it "should create a new instance" do
    proc { do_post }.should change(@model, :count).by(1)
  end

  def do_post format = 'html'
    post 'create', @assigns_model_name => @params, :format => format
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
  it { should assign_to(@assigns_model_name).with_kind_of(@model) }

  def do_post format = 'html'
    # TODO how to get invalid data here for an unknown class?
    post 'create', @assigns_model_name => Factory.attributes_for(:invalid_game),
        :format => format
  end
end

share_examples_for "POST create" do
  include CrudSetup

  context "with valid data" do
    it_should_behave_like "successful POST create"
  end

  context "with invalid data" do
    it_should_behave_like "unsuccessful POST create"
  end
end

share_examples_for "unauthorized PUT update" do
  include CrudSetup

  before do
    setup_crud_names
    @instance = Factory @assigns_model_name
    do_put
  end

  it { should redirect_to login_users_path }

  def do_put format = 'html'
    put 'update', :id => @instance, @assigns_model_name => @data,
        :format => format
  end
end

share_examples_for "PUT update" do
  include CrudSetup

  context "with valid data" do
    it_should_behave_like "successful PUT update"
  end

  context "with invalid data" do
    it_should_behave_like "unsuccessful PUT update"
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

  it { should set_the_flash }
  it "should redirect to the updated instance's show page" do
    should redirect_to eval("#{@model_name.underscore}_path @instance")
  end
  it "should update the instance" do
    @instance.updated_at.should_not eq(@instance.reload.updated_at)
  end

  context "should accept json" do
    before do
      do_put 'json'
    end
    it_should_behave_like JSONResponse
    it { should respond_with :success }
  end

  def do_put format = 'html'
    put 'update', :id => @instance, @assigns_model_name => @data,
        :format => format
  end
end

share_examples_for "unsuccessful PUT update" do
  include CrudSetup

  before do
    setup_crud_names
    @instance = Factory @assigns_model_name
    do_put
  end

  it { should set_the_flash }
  it "should redirect to the updated instance's edit page" do
    should redirect_to eval("#{@model_name.underscore}_path @instance")
  end
  it "should not update the instance" do
    @instance.updated_at.should eq(@instance.reload.updated_at)
  end

  def do_put format = 'html'
    put 'update', :id => @instance, :format => format
  end
end


share_examples_for "DELETE destroy" do
  include CrudSetup

  before do
    setup_crud_names
  end

  context "with a valid id" do
    before do
      @instance = Factory @assigns_model_name
      do_delete
    end

    it "should redirect to the model index when requesting HTML" do
      should redirect_to eval("#{@pluralized_assigns_model_name}_path")
    end

    context "should accept JSON" do
      before do
        do_delete 'json'
      end
      it_should_behave_like JSONResponse
      it { should respond_with :accepted }
    end

    def do_delete format = 'html'
      delete 'destroy', :id => @instance.to_param, :format => format
    end
  end

  context "with an invalid ID" do
    before do
      do_delete
    end

    it "should redirect to the model index when requesting HTML" do
      should redirect_to eval("#{@pluralized_assigns_model_name}_path")
    end

    it "should render a 404 when requesting JSON" do
      do_delete 'json'
      should respond_with :missing
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

    it { should respond_with :success }
    it { should render_template :edit }
    it { should assign_to(@assigns_model_name).with(@instance) }

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
    setup_crud_names
    @instance = Factory @assigns_model_name
    do_get
  end

  it { should redirect_to login_users_path }

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
  it { should assign_to(@assigns_model_name).with_kind_of(@model) }

  def do_get format = 'html'
    get 'new', :format => format
  end
end

share_examples_for "unauthorized GET new" do
  include CrudSetup

  before do
    do_get
  end

  it { should redirect_to login_users_path }

  def do_get format = 'html'
    get 'new', :format => format
  end
end
