Rails.application.routes.draw do

  get 'chats/create'
  get 'chats/show'
  get 'rooms/create'
  root to: 'homes#top'

  get 'home/about' => 'homes#about', as: 'about'
  
  get 'search' => 'searches#search'

  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => 'users/registrations'
  }
  
  resources :users, only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy] # :book_id :id　＝＞　/books/:book_id/book_comments/:id
  end
  
  resources :rooms, only: [:create]
  resources :chats, only: [:create, :show]

end