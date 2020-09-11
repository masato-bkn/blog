Rails.application.routes.draw do
  devise_for :users

  root 'home#top'
  resources :users
  resources :articles do
    resources :goods, only: [:create, :destroy], controller: 'articles/goods'
  end
  resources :comments, only: [:create, :destroy] do
    resources :goods, only: [:create, :destroy], controller: 'comments/goods'
  end
end
