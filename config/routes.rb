Rails.application.routes.draw do

  root to: "welcomes#index"
  get '/' => 'welcomes#index'

  post '/spots/create' => 'spots#create'

  get '/map' => 'welcomes#map'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]

end

# GoogleAuthExample::Application.routes.draw do


# end

