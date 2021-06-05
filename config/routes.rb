Rails.application.routes.draw do

  # ルートパス
  root to: 'homes#top'

  # ユーザのルーティング
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'relationships/followings' => 'relationships#followings', as: 'follows'
    get 'relationships/followers' => 'relationships#followers', as: 'followers'
  end

  # 投稿（鉄道）に関するルーティング
  resources :trains do
    resource :favorites, only: [:create, :destroy]
    resources :train_comments, only: [:create, :destroy]
  end

  # DMに関するルーティング
  resources :rooms, only: [:index, :show, :create]
  resources :messages, only: [:create]

  # 通知に関するルーティング
  get 'notifications/index'

  # 検索に関するルーティング
  get 'searches/search'

end
