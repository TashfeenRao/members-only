Rails.application.routes.draw do
  get 'users/new'
  get 'user/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/signin', to:'sessions#new'
  post '/signin', to:'sessions#create'
  delete '/signout', to:'sessions#destroy'
  resources :users
end
