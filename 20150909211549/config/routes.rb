Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  controller :sessions do
    get 'login' => :new, :as => :login
    post 'login' => :create, :as => :authenticate
    get 'auth/shopify/callback' => :callback
    get 'logout' => :destroy, :as => :logout
  end

  get   'edit_map',   to: 'maps#edit',   as: :edit_map
  patch 'update_map', to: 'maps#update', as: :update_map

  resources :stores
  resources :store_imports, only: [:new, :create]
  
  # public API
  get   'api_map',   to: 'api_maps#show',   as: :api_map

  root :to => 'home#index'

end
