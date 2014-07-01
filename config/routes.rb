Rails.application.routes.draw do
  root :to => 'session#new'
  resources :users
  resources :locations
  resources :moods

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
end
