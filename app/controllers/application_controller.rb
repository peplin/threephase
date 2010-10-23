class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  helper :all
  helper_method :current_user_session, :current_user, :current_game, 
      :current_state, :check_ownership

  before_filter :conditional_find_games
  before_filter :conditional_find_game

  if ::Rails.env == 'test'
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  end

  private

  def check_ownership valid
    if not current_user.admin and not valid
      flash[:notice] = "You can't change something you don't own."
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { head :unauthorized }
      end
      return false
    end
    return true
  end


  def conditional_find_generator
    if params[:generator_id]
      find_generator
    end
  end

  def find_generator
    @generator = Generator.find params[:generator_id]
  end

  def conditional_find_line
    if params[:line_id]
      find_line
    end
  end
  
  def find_line
    @line = Line.find params[:line_id]
  end

  def conditional_find_storage_device
    if params[:storage_device_id]
      find_storage_device
    end
  end

  def find_storage_device
    @storage_device = StorageDevice.find params[:storage_device_id]
  end

  def conditional_find_game
    if params[:game_id]
      find_game
    end
  end

  def conditional_find_games
    if not @game
      find_games
    end
  end

  def find_game
    game_required if not current_game
    @game = current_game
  end

  def current_game
    return @current_game if defined?(@current_game)
    if params[:game_id]
      @current_game = Game.find params[:game_id]
    elsif cookies[:current_game]
      @current_game = Game.find_by_id cookies[:current_game]
      if not @current_game
        cookies.delete :current_game
      end
    end
    if not @current_game and current_user and current_user.current_game
      @current_game = current_user.current_game
      cookies[:current_game] = (@current_game.id unless
          cookies[:current_game] == @current_game.id)
    end
    @current_game
  end

  def current_state
    current_user.current_state
  end

  def game_required
    unless current_game
      store_location
      flash[:notice] = "You must have an active game to access this page"
      respond_to do |format|
        format.html { redirect_to games_path }
        format.json { head :bad_request }
      end
      return false
    end
  end

  def find_games
    @games = Game.all
  end

  def render_not_found(exception)
    respond_to do |format|
      format.html { render "/errors/404", :status => 404 }
      format.json { head 404 }
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def login_required
    unless request.env['REMOTE_ADDR'] == '127.0.0.1' or current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { head :unauthorized }
      end
      return false
    end
  end

  def logout_required
    if current_user
      store_location
      redirect_to self_path
      return false
    end
  end

  def admin_required
    unless request.env['REMOTE_ADDR'] == '127.0.0.1' or (
        current_user and current_user.admin)
      store_location
      flash[:notice] = "You must be an administrator to access this page"
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { head :unauthorized }
      end
      return false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
