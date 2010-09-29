class UsersController < ApplicationController
  before_filter :admin_required, :only => [:index, :show]

  respond_to :json, :except => [:new]
  respond_to :html

  def index
  end

  def show
    if params[:id]
      @user = User.find params[:id]
    else
      @user = @current_user
    end
    @profile = @user.profile
  end

  def detonate
    # TODO remove this!
    session.clear
    User.all.collect(&:destroy)
    redirect_to login_url
  end
end
