Rails.application.routes.draw do
  devise_for :users
  resources :bookings
  resources :facilities
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  
   resources :facilities do
    resources :bookings, only: [:new, :create]
  end
  get '/tennis', to: 'facilities#tennis', as: 'tennis'
  get '/tennis', to: 'facilities#tennis', as: 'tennis_facilities'
  resources :bookings, only: [:index, :show, :edit, :update, :destroy]

  root 'facilities#index'
end
