Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/about' => 'home#about'
  get 'show' => 'home#show'
  get 'welcome' => 'home#welcome'
  root to: 'home#index'

  resources :bills do
    member do
      patch 'update_status'
      post 'send_email'
    end
  end

  resources :clients, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:edit, :update]
  resources :services, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :plans, only: [:index, :show]


  get 'bill/pdf/:id', to: 'bills#pdf', as: 'bill_pdf'
  get 'download', to: 'bills#download'
  get 'preview', to: 'bills#preview'
end
