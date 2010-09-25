class UsersController < ApplicationController
  before_filter :admin_required, :only => :index
  before_filter :logout_required, :only => [:new, :create]
  before_filter :login_required, :only => [:show, :edit, :update]

  def index
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    # TODO
  end

  def connect
    return create unless @current_user
    @user = @current_user # makes our views "cleaner" and more consistent
    @user.update_attributes(params[:user]) do |result|
      if result
        flash[:notice] = "Account updated!"
        redirect_to self_path
      else
        raise @user.errors.inspect
        render :action => :edit
      end
    end
  end
end
