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
end
