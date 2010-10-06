class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  helper :all
  helper_method :current_user_session, :current_user

  before_filter :conditional_find_games
  before_filter :conditional_find_game

  if ::Rails.env == 'test'
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  end

  private

  def find_generator
    if params[:generator_id]
      @generator = Generator.find params[:generator_id]
    end
  end

  def find_line
    if params[:line_id]
      @line = Line.find params[:line_id]
    end
  end

  def find_storage_device
    if params[:storage_device_id]
      @storage_device = StorageDevice.find params[:storage_device_id]
    end
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
    if params[:game_id]
      @game = Game.find params[:game_id]
    else
      @game = Game.find cookies[:current_game]
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
    unless current_user
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
    unless current_user and current_user.admin
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
