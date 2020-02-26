Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/signin', to:'sessions#new'
  post '/signin', to:'sessions#create'
  delete '/signout', to:'sessions#destroy'
  root 'posts#index'

  resources :users
  resources :posts , only: %i[new create index]
end
