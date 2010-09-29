require 'spec_helper'

describe "routing to static pages" do
  it "routes /about to static_pages#about" do
    {:get, "/about"}.should route_to(:action => "about", :controller => "static_pages")
  end
end
