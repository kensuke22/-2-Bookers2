Rails.application.routes.draw do
  
  root 'homes#top'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get :followings, :followers
    end
  end
    resources :relationships, only: %i[create destroy]
    
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  get 'home/about' => 'homes#about'
  get 'search/search' => 'searchs#search'
  
end