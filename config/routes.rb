Rails.application.routes.draw do
  devise_for :users,controllers:{
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    recoverables: 'users/recoverables'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")

  root "home#index" 

  resources :users do
    resources :orders
    resources :order_items, only: [:update]
    member do
      get '/products', to: 'users#products'
    end
  end

  resources :roles

  resources :products do
    member do
      get '/product_stock', to: 'products#product_stocks'
    end
  end 

  resources :categories do
    member do
      get '/product/:id', to: 'products#show', as: :see_product
    end
  end

  resources :product_stocks, only: [:index, :update, :create, :destroy, :edit]

  resources :cart_items, path: :cart, only: [:index, :create, :destroy] do
    member do
      patch '/increment', to: 'cart_items#increment'
      patch '/decrement', to: 'cart_items#decrement'
    end
  end

  get '/orders', to: 'orders#my_order'
  post '/orders', to: 'orders#create', as: "create_order"
end
