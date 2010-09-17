require 'spec_helper'

describe InterstateLinesController do
  before :each do
    @game = Game.all.first
    @interstate_line = InterstateLine.all.first
    @generator = Generator.all.first
    @region = Region.all.first
    @another_region = Region.all[1]
  end

  context "on GET to" do
    context "for HTML" do
      context ":index with a game" do
        before do
          get :index, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:interstate_lines) }
      end

      context ":index with a region" do
        before do
          get :index, :region => @region
        end

        it { should respond_with :success }
        it { should render_template :index }
        it { should assign_to(:interstate_lines) }
        it "should only include lines in the region" do
          assigns(:interstate_lines).each do |line|
            line.region.should eq(@region)
          end
        end
      end

      context ":new" do
        before do
          get :new, :game => @game
        end

        it { should respond_with :success }
        it { should render_template :new }
        it { should assign_to(:line).with_kind_of(Line) }
      end

      context ":show" do
        before do
          get :show, :id => @interstate_line
        end

        it { should respond_with :success }
        it { should render_template :show }
        it { should assign_to(:interstate_line).with(@interstate_line) }
      end
    end

    context "for JSON" do
      context ":index" do
        before do
          get :index, :game => @game, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end

      context ":show" do
        before do
          get :show, :id => @interstate_line, :format => "json"
        end

        it { should respond_with :success }
        it { should respond_with_content_type :json }
      end
    end
  end

  context "on POST to :create" do
    before do
      @data = {:incoming_region => @region, :outgoing_region => @another_region,
          :line_type => @line_type}
    end

    context "for HTML" do
      it "should create an interstate_line" do
        proc { post :create, :interstate_line => @data
            }.should change(InterstateLine, :count).by(1)
        should redirect_to region_path @region
        # TODO check that params are saved
      end
    end

    context "for JSON" do
      before do
        post :create, :interstate_line => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end

  context "on PUT to :respond" do
    before do
      @data = {:accepted => true}
    end

    context "for HTML" do
      it "should update an interstate_line" do
        proc { put :respond, :interstate_line => @data
            }.should_not change(InterstateLine, :count).by(1)
        should redirect_to region_path @region
        # TODO check that params are saved
      end
    end

    context "for JSON" do
      before do
        put :respond, :interstate_line => @data, :format => "json"
      end

      it { should respond_with :success }
    end
  end
end
