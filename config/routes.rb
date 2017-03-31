Rails.application.routes.draw do
  root   'topics#index'

  get    '/signup', to: 'users#new'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :topics, only: [:index, :show, :create, :destroy] do
    resources :posts, only: [:create]
  end

  get '/search', to: 'search#index', as: 'search'
end
