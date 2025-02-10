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

  # get '/users', to: 'users#index'

  # put '/users/:id/edit', to: 'users#edit', as: :edit_user
  resources :users do
    collection do
      get '/home', to: 'users#home'
    end
    member do
      get '/products', to: 'users#products'
    end
  end

  resources :roles

  resources :products 

  resources :categories
  resources :stocks, only: [:index, :update, :create, :destroy]

  # post '/add_stock', to: 'stocks#create'
end
