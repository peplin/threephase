class UsersController < ApplicationController
  before_filter :admin_required, :only => :index
  before_filter :login_required, :only => [:show, :edit, :update, :connect]

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

  def edit
    @user = @current_user
  end

  def update
    # TODO
  end

  def connect
    @user = @current_user # makes our views "cleaner" and more consistent
    @user.update_attributes(params[:user]) do |result|
      flash[:notice] = "Account updated!" if result
      redirect_to self_path
    end
  end

  def detonate
    session.clear
    User.all.collect(&:destroy)
    redirect_to login_url
  end
end
