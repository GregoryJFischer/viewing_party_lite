Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/register', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create', as: 'create_user'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'

  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/discover', to: 'users#discover', as: 'discover'

  root 'welcome#index'

  get '/users/:id/movies', to: 'movies#index'
  get '/users/:user_id/movies/:id', to: 'movies#show'

  get '/users/:user_id/movies/:movie_id/viewing-party/new', to: 'parties#new'
  post '/users/:user_id/movies/:movie_id/viewing-party', to: 'parties#create', as: 'new_party'
  post '/users/:user_id/parties', to: 'user_parties#create', as: 'new_user_party'
end
