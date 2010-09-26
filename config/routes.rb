Threephase::Application.routes.draw do
  resources :games, :except => [:destroy] do
    resources :regions, :only => [:index, :show, :new, :edit] do
      resources "interstate-lines", :controller => :interstate_lines,
          :as => :interstate_lines
      resources :zones, :only => [:index, :show]
    end

    resources :zones do
      resources :lines
      resources :generators
      resources "storage-devices", :controller => :storage_devices,
          :as => :storage_devices
      resources :prices, :controller => :markets, :only => [:index, :show]
    end

    resources :lines do
      resources :repairs, :only => [:index, :show]
    end
    resources "storage-devices", :controller => :storage_devices,
        :as => :storage_devices do
      resources :repairs, :only => [:index, :show]
    end
    resources :generators do 
      resources :bids, :except => [:update, :destroy]
      resources :contracts, :only => [:index, :show]
      resources :repairs, :only => [:index, :show]
    end

    resources :bids, :only => [:index, :show]
    resources :contracts, :only => [:index, :show]
    resources "interstate-lines", :controller => :interstate_lines,
        :as => :interstate_lines

    resources :prices, :controller => :markets, :only => [:index, :show]
    resources :repairs, :only => [:index, :show]
    resources :advancements, :controller => :research_advancements,
        :only => [:create, :index, :show]
    resources "storage-devices", :controller => :storage_devices, :as => :storage_devices
  end

  resources :generators, :only => [:show, :edit, :create, :update] do
    collection do
      resources :types, :controller => :generator_types, :as => :generator_types
    end
    resources :bids, :except => [:update, :destroy]
  end

  resources :bids, :only => [:show, :create]

  resources :contracts, :only => [:index, :show]
  match "/contracts/:id" => "contracts#offer", :via => :post
  match "/offers" => "contracts#offer", :via => :post
  match "/offers/:id" => "contracts#respond", :via => :put

  resources "interstate-lines", :controller => :interstate_lines,
      :as => :interstate_lines, :only => [:index, :show, :create, :update]

  resources :lines, :except => [:index] do
    collection do
      resources :types, :controller => :line_types, :as => :line_types
    end
  end

  resources "storage-devices", :controller => :storage_devices, :except => [:index],
      :as => :storage_devices do
    collection do
      resources :types, :controller => :storage_device_types,
          :as => :storage_device_types
    end
  end

  resources :regions, :only => [:show, :update, :create]
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

  root :to => 'games#index'
end
