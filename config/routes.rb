Rails.application.routes.draw do

  root to: "welcomes#index"
  get '/' => 'welcomes#index'
  get '/user' => 'welcomes#user'
  put '/user/:id' => 'users#update'
  get '/user/spot/:id' => 'spot#show'

  put '/user/spot/:id/update' => 'spots#update'

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

