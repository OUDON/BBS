Rails.application.routes.draw do
  root   'topics#index'

  get    '/signup', to: 'users#new'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users,  only: [:show, :new, :create, :edit, :update]
  resources :topics, only: [:index, :show, :create, :destroy]
end
