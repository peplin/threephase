share_examples_for "show with a game" do
  include CrudSetup

  context "on GET to :show with a game" do
    before do
      @game = Factory :game
    end

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
  end

  context "as an admin" do
    it_should_behave_like "index with a game"
    it_should_behave_like "new with a game"
    it_should_behave_like "standard GET edit"
    it_should_behave_like "standard GET show"

    context "on POST to :create" do
      context "with valid data" do
        it_should_behave_like "standard successful POST create"

        def redirect_path
          region_path assigns(:instance).region
        end
      end

      context "with invalid data" do
        it_should_behave_like "standard unsuccessful POST create"
      end
    end

    context "on PUT to :update" do
      context "with valid data" do
        it_should_behave_like "standard successful PUT update"

        def do_put format='html'
          symbol = @instance.class.to_s.underscore.to_sym
          put :update, :id => @instance, symbol => @data, :format => format
        end
      end

      context "with invalid data" do
        it_should_behave_like "standard unsuccessful PUT update"
      end
    end
  end

  context "as an authorized player" do
    it "should allow me to create an instance for my game"
    it "should allow me to update a instance"
  end
  
  context "as an unauthorized player" do
    it "should not allow me to create an instance for someone else's game"
    it "should not allow me to update someone else's instance"
  end

  context "as an anonymous user" do
    it "should not allow me to create an instance"
  end
end

