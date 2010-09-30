class UsersController < ApplicationController
  before_filter :admin_required, :only => [:index, :show]

  respond_to :json, :html

  def index
    @users = User.all
    respond_with @users
  end

  def show
    if params[:id]
      @user = User.find params[:id]
    else
      @user = @current_user
    end
    @profile = @user.profile
    respond_with @user
  end

  def detonate
    if ::Rails.env == "development"
      session.clear
      User.all.collect(&:destroy)
      redirect_to login_url
    end
  end
end
