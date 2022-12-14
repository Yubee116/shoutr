Rails.application.routes.draw do
  resources :shouts
  constraints Clearance::Constraints::SignedIn.new do
    root to: 'dashboards#show', as: 'signed_in_root'
  end
  get 'dashboards/show'
  root 'home#show'

  resources :passwords, controller: 'clearance/passwords', only: %i[create new]
  resource :session, only: [:create]

  resources :users, only: [:create] do
    resource :password,
             controller: 'clearance/passwords',
             only: %i[edit update]
  end

  get '/sign_in' => 'sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'users#new', as: 'sign_up'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
