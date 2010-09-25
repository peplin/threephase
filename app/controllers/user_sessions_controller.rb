class UserSessionsController < ApplicationController
  before_filter :logout_required, :only => [:new, :create]
  before_filter :login_required, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|
      if result
        flash[:notice] = "Login successful."
        redirect_to current_user ? profile_url(current_user) : login_url
      else
        if @user_session.errors.on(:user)
          render :action => :confirm
        else
          render :action => :new
        end
      end
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful."
    redirect_to login_url
  end
end
