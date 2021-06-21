class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  # フォロー機能のコントローラー

  # フォローする
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notification_follow!(current_user)
  end

  # フォロー外す
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
  end

  # フォロー一覧画面
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(10)
  end

  # フォロワー一覧画面
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(10)
  end
end
