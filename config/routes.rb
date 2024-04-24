Rails.application.routes.draw do
  devise_for :users
  resources :events do
    resources :invitations, only: [:new, :create, :destroy] do
      member do
        patch 'accept'
        patch 'reject'
      end
    end
  end
  resources :notifications, only: [:index] do
    member do
      patch :mark_as_read
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
 root "events#index"
end
