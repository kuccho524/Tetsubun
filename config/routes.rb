Rails.application.routes.draw do
  # ルートパス
  root to: 'homes#top'

  # ユーザ認証機能のルーティング
  devise_for :users

  # ゲストユーザ
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

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

  # いいね一覧画面のルーティング
  resources :favorites, only: [:index]

  # チャットルームのルーティング
  resources :rooms, only: [:index, :show, :create]

  # メッセージのルーティング
  resources :messages, only: [:create, :destroy]

  # 通知のルーティング
  get 'notifications/index' => 'notifications#index', as: 'notifications'
  delete 'notifications/destroy_all' => 'notifications#destroy_all', as: 'notification_all_delete'

  # 検索のルーティング
  get 'searches/search' => 'searches#search', as: 'search'
end
