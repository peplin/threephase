Threephase::Application.routes.draw do
  resources :games, :except => [:destroy] do
    resources :regions, :only => [:index, :show] do
      resources :interstatelines, :controller => :interstate_lines,
          :as => :interstate_lines
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
          :only => [:index, :show, :new], :as => :contract_negotiations
      resources :repairs
    end

    resources :bids, :only => [:index, :show]
    resources :contracts, :controller => :contract_negotiations,
        :as => :contract_negotiations
    resources :interstatelines, :controller => :interstate_lines,
        :as => :interstate_lines

    resources :prices, :controller => :market_prices, :only => [:index, :show]
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

  resources :contracts, :controller => :contract_negotiations,
      :only => [:index, :show, :create],:as => :contract_negotiations do
  end

  match "/offers" => "contract_negotiations#offer"
  resources :offers, :controller => :contract_negotiations, :as => :offers,
    :only => [:update]

  resources :interstatelines, :controller => :interstate_lines,
      :as => :interstate_lines, :only => [:index, :show, :create, :update]

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
      :only => [:show, :create]
  resources :zones, :only => [:show, :create]

  match 'login' => "user_sessions#new"
  match 'logout' => "user_sessions#destroy"
  match 'authenticate' => "user_sessions#create"
  match 'connect' => "users#connect"
  match 'detonate' => "users#detonate"
  resources :users, :only => [:index, :show, :edit, :update]
  resource :user, :only => [:show, :edit, :update], :as => :self
end
