Rails.application.routes.draw do
  devise_for :users

  root 'home#top'
  resources :users
  resources :articles do
    resources :article_goods, only: [:create, :destroy]
  end
  resources :comments, only: [:create, :destroy]
end
