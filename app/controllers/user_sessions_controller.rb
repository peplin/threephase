class UserSessionsController < ApplicationController
  before_filter :logout_required, :only => [:create]
  before_filter :login_required, :only => :destroy
  
  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.remember_me = true
    @user_session.save do |result|
      if result
        flash[:notice] = "Login successful."
      else
        flash[:notice] = "Registration successful."
      end
      redirect_to current_user ? profile_url(current_user) : root_path
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful."
    redirect_to login_url
  end
end
