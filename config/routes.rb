Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  resources :bills do
    member do
      get 'generate_pdf'
    end
    member do
      patch 'update_status'
    end
  end
  resources :clients
  resources :users

  devise_scope :user do
    authenticated :user do
      root 'bills#index', as: :authenticated_root
    end

    # Redirect users to login page if not authenticated
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
