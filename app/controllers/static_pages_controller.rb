class StaticPagesController < ApplicationController

  def about
    render :about, :layout => "wide"
  end

  def index
    render :about, :layout => "wide"
  end
end
