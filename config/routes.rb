Rails.application.routes.draw do

  root to: "welcomes#index"
  get '/' => 'welcomes#index'
  get '/user' => 'welcomes#user', as: 'user_home'

  put '/user/:id' => 'users#update', as: 'user_update'

  get '/user/spot/:id' => 'spots#show'

  put '/user/spot/:id/update' => 'spots#update', as: 'spot_update'

  post '/spots/create' => 'spots#create'

  get '/map' => 'welcomes#map'
  get 'spots/current.json' => 'welcomes#user_current_spot'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]

end

# GoogleAuthExample::Application.routes.draw do


# end

