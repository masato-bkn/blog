Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#top'
  resources :users
  resources :articles
  resources :goods, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end
