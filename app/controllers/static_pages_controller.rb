class StaticPagesController < ApplicationController

  def about
  end

  def index
    render :about
  end
end
