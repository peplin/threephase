Threephase::Application.routes.draw do
  resources :games, :except => [:destroy] do
    resources :states, :only => [:index, :show] do
      resources :zones, :only => [:index, :show]
    end
    resources :prices, :controller => :markets, :only => [:index, :show]
    resources :zones, :only => [:index, :show]
  end

  resources :states, :only => [:index, :show, :update, :create, :edit, :new] do
    resources :zones, :only => [:index, :show]
    resources "interstate-lines", :controller => :interstate_lines,
        :as => :interstate_lines, :only => [:index, :show, :create, :update, :new]
  end
  resources :advancements, :controller => :research_advancements,
      :only => [:index, :show, :create]
  resources "interstate-lines", :controller => :interstate_lines,
      :as => :interstate_lines, :only => [:index, :show, :create, :update]

  resources :zones, :only => [:index, :show] do
    resources :lines
    resources :generators
    resources "storage-devices", :controller => :storage_devices,
        :as => :storage_devices
    resources :prices, :controller => :markets, :only => [:index, :show]
  end

  resources :prices, :controller => :markets, :only => [:index, :show]
  resources :lines do
    resources :repairs, :only => [:index, :show]
    collection do
      resources :types, :controller => :line_types, :as => :line_types
    end
  end

  resources "storage-devices", :controller => :storage_devices,
      :as => :storage_devices do
    resources :repairs, :only => [:index, :show]
    collection do
      resources :types, :controller => :storage_device_types,
          :as => :storage_device_types
    end
  end

  resources :generators, :except => [:delete] do
    collection do
      resources :types, :controller => :generator_types, :as => :generator_types
    end
    resources :bids, :except => [:update, :destroy]
    resources :contracts, :only => [:index, :show]
    resources :repairs, :only => [:index, :show]
  end

  resources :bids, :only => [:index, :show, :create]
  resources :repairs, :except => [:destroy, :update]
  resources :contracts, :only => [:index, :show]
  match "/contracts/:id" => "contracts#offer", :via => :post
  match "/offers" => "contracts#offer", :via => :post
  match "/offers/:id" => "contracts#respond", :via => :put


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
