Rails.application.routes.draw do
  devise_for :users

  root 'home#top'
  resources :users
  resources :articles do
    resources :goods
  end
  # TODO リファクタ後に削除する
  resources :article_goods, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :comment_goods, only: [:create, :destroy]
end
