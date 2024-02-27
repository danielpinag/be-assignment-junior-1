Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  root to: "static#dashboard"

  resources :friendships, only: %i[index create destroy] do
    patch 'accept', on: :member
  end

  resources :users, only: %i[show]

  resources :expenses, only: %i[create]

  namespace :expenses do
    resources :shares do
      get 'new_payment', to: 'shares#new_payment', as: :new_payment
      resources :payments, only: %i[create], controller: 'shares/payments'
    end
  end
end
