Rails.application.routes.draw do
  get 'home/show'

  get 'sessions/create'

  get 'sessions/destroy'

  get '/' => 'welcomes#index'

  post '/spots/create' => 'spots#create'

  get '/map' => 'welcomes#map'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: "home#show"
end

# GoogleAuthExample::Application.routes.draw do

  get 'home/show'

# end

