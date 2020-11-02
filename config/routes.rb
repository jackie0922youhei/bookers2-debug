Rails.application.routes.draw do

  root to: 'homes#top'
  
  get 'home/about' => 'homes#about', as: 'about'
  
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update]
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy] # :book_id :id　＝＞　/books/:book_id/book_comments/:id
  end


end