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
    @model_name = @model.to_s
    @model_symbol = @model_name.to_sym
    @pluralized_model_name = @model_name.humanize.pluralize
    unless @factory_name
      @factory_name = @model_name.underscore.to_sym
    end
    unless @invalid_factory_name
      @invalid_factory_name = "invalid_#{@model_name.underscore}".to_sym
    end
    unless @another_factory_name
      @another_factory_name = "another_#{@model_name.underscore}".to_sym
    end
    unless @assigns_model_name
      @assigns_model_name = @model_name.underscore.to_sym
    end
    unless @param_symbol
      @param_symbol = @assigns_model_name
    end
    @pluralized_redirect_name = @model_name.underscore.pluralize.to_sym
    unless @pluralized_assigns_model_name
      @pluralized_assigns_model_name = @model_name.underscore.pluralize.to_sym
    end
  end

  def subject
    # This is to fix a bug in Shoulda - get undefined attributes without it
    @controller
  end
end

share_as :JSONResponse do
  include CrudSetup

  it { should respond_with_content_type :json }
end

share_examples_for "unsuccessful GET index" do
  include CrudSetup

  context "for HTML" do
    before do
      do_get
    end

    it { should respond_with :missing }
  end

  context "for JSON" do
    before do
      do_get 'json'
    end

    it { should respond_with :missing }
  end
end

share_examples_for "successful GET index" do
  include CrudSetup

  before do
    setup_crud_names
  end

  context "for HTML" do
    before do
      do_get
    end

    it { should respond_with :success }
    it { should render_template :index }

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
end

share_examples_for "standard GET index" do
  include CrudSetup

  it_should_behave_like "successful GET index"

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

share_examples_for "successful GET show" do
  include CrudSetup

  before :all do
    setup_crud_names
    @instance = Factory @factory_name
  end

  before do
    do_get
  end

  it { should respond_with :success }
  it { should render_template :show }

  it { should assign_to(@assigns_model_name).with(@instance) }

  context "should accept JSON" do
    before do
      do_get 'json'
    end
    it_should_behave_like JSONResponse
    it { should respond_with :success }
  end
end

share_examples_for "unsuccessful GET show" do
  include CrudSetup

  before do
    setup_crud_names
    do_get
  end

  it { should respond_with :missing }
  it { should render_template '404' }
  it { should_not assign_to(@assigns_model_name) }

  it "should send a 404 if not found via JSON" do
    do_get 'json'
    should respond_with :missing
  end
end

share_examples_for "standard successful GET show" do
  include CrudSetup

  it_should_behave_like "successful GET show"

  def do_get format='html'
    get :show, :id => @instance, :format => format
  end
end

share_examples_for "standard unsuccessful GET show" do
  include CrudSetup

  it_should_behave_like "unsuccessful GET show"

  def do_get format = 'html'
    get :show, :id => -1, :format => format
  end
end

share_examples_for "standard GET show" do
  include CrudSetup

  it_should_behave_like "standard successful GET show"
  it_should_behave_like "standard unsuccessful GET show"

end

share_examples_for "unauthorized GET show" do
  include CrudSetup

  before :all do
    setup_crud_names
    @instance = Factory @factory_name
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
    get :show, :id => @instance, :format => format
  end
end

share_examples_for "unauthorized POST create" do
  include CrudSetup

  before do
    setup_crud_names
    if not @data
      @data = Factory.attributes_for(@factory_name).update(
          Factory(@factory_name).attributes)
    end
    if not @another_user
      @another_user = Factory :user
    end
    State.any_instance.stubs(:user).returns(@another_user)
    do_post
  end

  it { should redirect_to login_path }

  def do_post format = 'html'
    post 'create', @param_symbol => @data, :format => format
  end
end

share_examples_for "successful POST create" do
  include CrudSetup

  before :all do
    setup_crud_names
    if not @data
      @data = Factory.attributes_for(@factory_name).update(
          Factory(@factory_name).attributes)
    end
  end

  context "normal post" do
    before do
      do_post
    end

    it { should set_the_flash }

    it "should redirect to the new instance's show page" do
      if self.respond_to? :redirect_path
        should redirect_to redirect_path
      else
        @instance = assigns(@assigns_model_name)
        should redirect_to eval("#{@model_name.underscore}_path @instance")
      end
    end
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
end

share_examples_for "standard successful POST create" do
  include CrudSetup

  it_should_behave_like "successful POST create"

  def do_post format = 'html'
    post 'create', @param_symbol => @data, :format => format
  end
end

share_examples_for "unsuccessful POST create" do
  include CrudSetup

  before :all do
    setup_crud_names
    if not @data
      @data = Factory.attributes_for(@invalid_factory_name)
    end
  end

  before do
    do_post
  end

  it { should render_template :new }
  it { should assign_to(@assigns_model_name).with_kind_of(@model) }
end

share_examples_for "standard unsuccessful POST create" do
  include CrudSetup

  it_should_behave_like "unsuccessful POST create"

  def do_post format = 'html'
    post 'create', @param_symbol => @data, :format => format
  end
end

share_examples_for "standard POST create" do
  include CrudSetup

  it_should_behave_like "standard successful POST create"
  it_should_behave_like "standard unsuccessful POST create"
end

share_examples_for "unauthorized PUT update" do
  include CrudSetup

  before :all do
    setup_crud_names
    @instance = Factory @factory_name
  end

  before do
    do_put
  end

  it { should redirect_to login_path }

  def do_put format = 'html'
    put 'update', :id => @instance, @param_symbol => @data,
        :format => format
  end
end

share_examples_for "standard PUT update" do
  include CrudSetup

  context "with valid data" do
    it_should_behave_like "standard successful PUT update"
  end

  context "with invalid data" do
    it_should_behave_like "standard unsuccessful PUT update"
  end
end

share_examples_for "successful PUT update" do
  include CrudSetup
  
  before :all do
    setup_crud_names
    @instance = Factory @factory_name
    @data = Factory(@another_factory_name).attributes
  end

  before do
    do_put
  end

  it { should set_the_flash }

  it "should redirect to the updated instance's show page" do
    if self.respond_to? :redirect_path
      should redirect_to redirect_path
    else
      should redirect_to eval("#{@model_name.underscore}_path @instance")
    end
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
end

share_examples_for "standard successful PUT update" do
  include CrudSetup

  it_should_behave_like "successful PUT update"

  def do_put format = 'html'
    put 'update', :id => @instance, @param_symbol => @data,
        :format => format
  end
end

share_examples_for "unsuccessful PUT update" do
  include CrudSetup

  before :all do
    setup_crud_names
    @instance = Factory @factory_name unless @instance
  end

  before do
    do_put
  end

  it { should set_the_flash }
  it "should redirect to the updated instance's edit page" do
    if self.respond_to? :redirect_path
      should redirect_to redirect_path
    else
      should redirect_to eval("#{@model_name.underscore}_path @instance")
    end
  end
  it "should not update the instance" do
    @instance.updated_at.should be_close(@instance.reload.updated_at, 0.1)
  end
end

share_examples_for "standard unsuccessful PUT update" do
  include CrudSetup

  it_should_behave_like "unsuccessful PUT update"

  def do_put format = 'html'
    put 'update', :id => @instance, :format => format
  end
end

share_examples_for "successful DELETE destroy" do
  include CrudSetup

  before :all do
    setup_crud_names
    @instance = Factory @factory_name
  end

  context "for HTML"  do
    before do
      do_delete
    end

    it "should redirect to the model index when requesting HTML" do
      if self.respond_to? :redirect_path
        should redirect_to redirect_path
      else
        should redirect_to eval("#{@pluralized_redirect_name}_path")
      end
    end
  end

  context "should accept JSON" do
    before do
      do_delete 'json'
    end
    it { should respond_with :accepted }
  end
end

share_examples_for "unsuccessful DELETE destroy" do
  include CrudSetup

  before do
    setup_crud_names
  end

  it "should redirect to the model index when requesting HTML" do
    do_delete
    should respond_with :missing
  end

  it "should render a 404 when requesting JSON" do
    do_delete 'json'
    should respond_with :missing
  end
end

share_examples_for "standard successful DELETE destroy" do
  include CrudSetup

  it_should_behave_like "successful DELETE destroy"

  def do_delete format = 'html'
    delete :destroy, :id => @instance, :format => format
  end
end

share_examples_for "standard unsuccessful DELETE destroy" do
  include CrudSetup

  it_should_behave_like "unsuccessful DELETE destroy"

  def do_delete format = 'html'
    delete :destroy, :id => -1, :format => format
  end
end

share_examples_for "standard DELETE destroy" do
  include CrudSetup

  it_should_behave_like "standard successful DELETE destroy"
  it_should_behave_like "standard unsuccessful DELETE destroy"
end

share_examples_for "successful GET edit" do
  include CrudSetup

  before :all do
    setup_crud_names
    @instance = Factory @factory_name
  end

  before do
    do_get
  end

  it { should respond_with :success }
  it { should render_template :edit }
  it { should assign_to(@assigns_model_name).with(@instance) }
end

share_examples_for "standard successful GET edit" do
  include CrudSetup

  it_should_behave_like "successful GET edit"

  def do_get format = 'html'
    get :edit, :id => @instance, :format => format
  end
end

share_examples_for "unsuccessful GET edit" do
  include CrudSetup

  before do
    setup_crud_names
    do_get
  end

  it { should respond_with :missing }
  it { should render_template '404' }
  it { should_not assign_to(@assigns_model_name) }
end

share_examples_for "standard unsuccessful GET edit" do
  include CrudSetup

  it_should_behave_like "unsuccessful GET edit"

  def do_get format = 'html'
    get :edit, :id => -1, :format => format
  end
end

share_examples_for "standard GET edit" do
  include CrudSetup

  it_should_behave_like "standard successful GET edit"
  it_should_behave_like "standard unsuccessful GET edit"
end

share_examples_for "unauthorized GET edit" do
  include CrudSetup

  before :all do
    setup_crud_names
    @instance = Factory @factory_name
  end

  before do
    do_get
  end

  it { should redirect_to login_path }

  def do_get format = 'html'
    get :edit, :id => @instance, :format => format
  end
end

share_examples_for "unsuccessful GET new" do
  include CrudSetup

  before do
    do_get
  end

  it { should respond_with :missing }
end

share_examples_for "successful GET new" do
  include CrudSetup

  before do
    setup_crud_names
    do_get
  end

  it { should respond_with :success }
  it { should render_template :new }
  it { should assign_to(@assigns_model_name).with_kind_of(@model) }
end

share_examples_for "standard GET new" do
  include CrudSetup

  it_should_behave_like "successful GET new"

  def do_get format = 'html'
    get :new, :format => format
  end
end

share_examples_for "unauthorized GET new" do
  include CrudSetup

  before do
    do_get
  end

  it { should redirect_to login_path }

  def do_get format = 'html'
    get :new, :format => format
  end
end
