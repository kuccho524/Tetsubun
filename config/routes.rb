Rails.application.routes.draw do

  # ルートパス
  root to: 'homes#top'

  # ユーザ認証機能のルーティング
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    paswords: 'users/paswords',
    registrations: 'users/registrations',
  }

  # ユーザのルーティング
  resources :users, only: [:show, :edit, :update] do

    # フォロー機能のルーティング
    resource :relationships, only: [:create, :destroy]
    get 'relationships/followings' => 'relationships#followings', as: 'follows'
    get 'relationships/followers' => 'relationships#followers', as: 'followers'
  end

  # 投稿（鉄道）に関するルーティング
  resources :trains do

    # いいね機能のルーティング
    resource :favorites, only: [:create, :destroy]

    # コメント機能のルーティング
    resources :train_comments, only: [:create, :destroy]
  end

  # チャットルームのルーティング
  resources :rooms, only: [:index, :show, :create]

  # メッセージのルーティング
  resources :messages, only: [:create]

  # 通知のルーティング
  get 'notifications/index'

  # 検索のルーティング
  get 'searches/search'

end
