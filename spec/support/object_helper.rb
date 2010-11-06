share_examples_for "show with a game" do
  include CrudSetup

  before do
    @game = Factory :game
  end

  context "on GET to :show with a game" do

    it_should_behave_like "successful GET show"

    def do_get format='html'
      get :show, :game_id => @game, :id => @instance, :format => format
    end
  end

  context "on GET to :show with an invalid game" do
    it_should_behave_like "unsuccessful GET show"

    def do_get format='html'
      get :show, :game_id => @game, :id => -1, :format => format
    end
  end
end

share_examples_for "index with a game" do
  include CrudSetup

  context "on GET to :index with a game" do
    before do
      @game = Factory :game
    end

    it_should_behave_like "successful GET index"

    def do_get format='html'
      get :index, :game_id => @game, :format => format
    end
  end

  context "on GET to :index with an invalid game" do
    it_should_behave_like "unsuccessful GET index"

    def do_get format='html'
      get :index, :game_id => -1, :format => format
    end
  end
end

share_examples_for "new with a game" do
  include CrudSetup

  context "on GET to :new with a game" do
    before do
      @game = Factory :game
    end

    it_should_behave_like "successful GET new"

    def do_get format='html'
      get :new, :game_id => @game, :format => format
    end
  end

  context "on GET to :new with an invalid game" do
    it_should_behave_like "unsuccessful GET new"

    def do_get format='html'
      get :new, :game_id => -1, :format => format
    end
  end
end

share_examples_for "a technical component instance" do
  include CrudSetup

  before :all do
    @assigns_model_name = :instance
    @pluralized_assigns_model_name = :instances
    @param_symbol = @instance.class.name.underscore.to_sym
  end

  context "as an admin" do
    before do
      login_as_admin
    end

    it_should_behave_like "index with a game"
    it_should_behave_like "new with a game"
    it_should_behave_like "standard GET edit"
    it_should_behave_like "standard GET show"

    context "on GET to :levels" do
      before do
        setup_crud_names
        @instance = Factory @factory_name
        get :levels, :id => @instance, :format => 'json' 
      end

      it_should_behave_like JSONResponse
      it { should respond_with :success }
      it "should return a list of average operating levels" do
        json_response[0]["average_operating_level"]["operating_level"].should eq(
            @instance.average_operating_levels.first.operating_level)
      end
    end

    context "on POST to :create" do
      context "with valid data" do
        it_should_behave_like "standard successful POST create"

        def redirect_path
          city_path assigns(:instance).city
        end
      end

      context "with invalid data" do
        it_should_behave_like "standard unsuccessful POST create"
      end
    end

    context "on PUT to :update" do
      context "with valid data" do
        it_should_behave_like "standard successful PUT update"
      end

      context "with invalid data" do
        it_should_behave_like "standard unsuccessful PUT update"
      end
    end
  end

  context "as an authorized player" do
    before do
      login
      State.any_instance.stubs(:user).returns(@current_user)
    end

    context "create" do
      it_should_behave_like "standard successful POST create"

      def redirect_path
        city_path assigns(:instance).city
      end
    end

    it_should_behave_like "standard successful PUT update"
  end
  
  context "as an unauthorized player" do
    before do
      login
    end

    it_should_behave_like "unauthorized POST create"
    it_should_behave_like "unauthorized PUT update"
  end

  context "as an anonymous user" do
    it_should_behave_like "unauthorized POST create"
  end
end

