Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  root to: "static#dashboard"
  get 'people/:id', to: 'static#person'

  resources :friendships, only: %i[index create destroy] do
    patch 'accept', on: :member
  end

  resources :users, only: %i[show]
end
