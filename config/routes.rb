Rails.application.routes.draw do
  
  root 'homes#top'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  get 'home/about' => 'homes#about'
  
end