Rails.application.routes.draw do
   devise_for :users
   root to: 'homes#top'
  get "home/about" => "homes#about"
  resources :books
  resources :books, only: [:new, :edit, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
      resources :book_comments, only: [:create, :destroy]
  end
  resources :users
 end