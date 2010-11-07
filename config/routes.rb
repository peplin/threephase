Threephase::Application.routes.draw do
  resources :games, :except => [:destroy] do
    resources :states, :only => [:index, :show, :new] do
      post :switch, :on => :collection
      member do
        get :prices
        get :curve
        get :map
      end
      resources :cities, :only => [:index, :show]
    end
    resources :prices, :controller => :fuel_markets, :only => [:index, :show]
    resources :cities, :only => [:index, :show]
  end

  resources :states,
      :only => [:index, :show, :update, :create, :edit, :destroy] do
    resources :cities, :only => [:index, :show]
    resources "interstate-lines", :controller => :interstate_lines,
        :as => :interstate_lines,
        :only => [:index, :show, :create, :update, :new]
    member do
      get :prices
      get :curve
      get :map
    end
  end
  resources :advancements, :controller => :research_advancements,
      :only => [:index, :show, :create]
  resources "interstate-lines", :controller => :interstate_lines,
      :as => :interstate_lines, :only => [:index, :show, :create, :update, :new]

  match "/cities/:id/load-profile" => "cities#load_profile", :via => :get
  resources :cities, :only => [:index, :show] do
    resources :lines do
      get :levels, :on => :member
    end
    resources :generators do
      member do
        get :levels
        get :costs
        get :curve
      end
    end
    resources :prices, :controller => :fuel_markets, :only => [:index, :show]
  end

  resources :prices, :controller => :fuel_markets, :only => [:index, :show]
  resources :lines do
    resources :repairs, :only => [:index, :show]
    collection do
      resources :types, :controller => :line_types, :as => :line_types
    end
    get :levels, :on => :member
  end

  resources :generators, :except => [:destroy] do
    collection do
      resources :types, :controller => :generator_types,
          :as => :generator_types
    end
    resources :bids, :except => [:update, :destroy]
    resources :repairs, :only => [:index, :show]
    member do
      get :levels
      get :costs
    end
  end

  resources :bids, :only => [:show, :create]
  resources :repairs, :except => [:destroy, :update]

  match 'login' => "user_sessions#new", :via => :get
  match 'logout' => "user_sessions#destroy", :via => :get
  match 'authenticate' => "user_sessions#create", :via => :post
  if ::Rails.env == 'development'
    match 'detonate' => "users#detonate", :via => :get
  end
  resources :users, :only => [:index, :show]

  match 'about' => "static_pages#about", :via => :get

  root :to => 'static_pages#index'
end
