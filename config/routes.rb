Rails.application.routes.draw do
  devise_for :users

  root 'home#top'
  resources :users
  resources :articles
  resources :article_goods, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end
