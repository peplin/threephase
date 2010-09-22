Threephase::Application.routes.draw do
  resources :games, :except => [:destroy] do
    resources :regions, :only => [:index, :show] do
      resources :interstatelines, :controller => :interstate_lines
      resources :zones, :only => [:index, :show]
    end

    resources :zones do
      resources :lines
      resources :generators
      resources :stores, :controller => :storage_devices,
          :as => :storage_devices
      resources :prices, :controller => :market_prices, :only => [:index, :show]
    end

    resources :lines
    resources :stores, :controller => :storage_devices, :as => :storage_devices
    resources :generators do 
      resources :bids, :except => [:update, :destroy]
      resources :contracts, :controller => :contract_negotiations,
          :only => [:index, :show, :new]
      resources :repairs
    end

    resources :bids, :only => [:index, :show]
    resources :contracts, :controller => :contract_negotiations
    resources :interstatelines, :controller => :interstate_lines

    resources :prices, :controller => :market_prices,
        :only => [:index, :show]
    resources :repairs
    resources :advancements, :controller => :research_advancements,
        :only => [:create, :index, :show]
    resources :stores, :controller => :storage_devices, :as => :storage_devices
  end

  resources :generators, :only => [:show, :edit, :create, :update] do
    collection do
      resources :types, :controller => :generator_types, :as => :generator_types
    end
    resources :bids, :except => [:update, :destroy]
  end

  resources :bids, :only => [:show, :create]

  match "/offers/:id" => "contract_negotiations#respond", :via => :put
  match "/contracts/:contract_id/offers" => "contract_negotiations#offer",
      :via => :post
  resources :contracts, :controller => :contract_negotiations,
      :only => [:index, :show, :create] do
    resources :offers, :controller => :contract_negotiations
  end
  resources :offers, :controller => :contract_negotiations

  resources :interstatelines, :controller => :interstate_lines,
      :only => [:index, :show, :create, :update]

  resources :lines, :except => [:index] do
    collection do
      resources :types, :controller => :line_types, :as => :line_types
    end
  end

  resources :stores, :controller => :storage_devices, :except => [:index],
      :as => :storage_devices do
    collection do
      resources :types, :controller => :storage_device_types,
          :as => :storage_device_types
    end
  end

  resources :regions, :only => [:show, :update]
  resources :repairs, :except => [:index, :destroy, :update]
  resources :advancements, :controller => :research_advancements,
      :only => [:create]
  resources :zones, :only => [:show, :create]

  resources :users, :path_names => {:new => 'signup'}, :except => [:create] do
    collection do
      get 'login', :action => :new, :controller => :user_sessions
      get 'logout', :action => :destroy, :controller => :user_sessions
      post 'authenticate', :action => :create, :controller => :user_sessions
      get 'reset', :action => :detonate
      put 'connect'
    end
  end
  resource :user

end
