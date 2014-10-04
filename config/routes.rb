Rails.application.routes.draw do
  resources :instances

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
