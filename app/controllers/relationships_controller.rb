class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  # フォロー機能のコントローラー

  # フォローする
  def create
    current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  # フォロー外す
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  # フォロー一覧画面
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  # フォロワー一覧画面
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
