Rails.application.routes.draw do

  root to: 'homes#top'

  get 'home/about' => 'homes#about', as: 'about'

  get 'search' => 'searches#search'

  post '/homes/guest_sign_in', to: 'homes#new_guest'

  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => 'users/registrations',
    :passwords => 'users/passwords'
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
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :notifications, only: :index

end