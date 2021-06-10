class FavoritesController < ApplicationController
  before_action :authenticate_user!

  # いいね機能のコントローラー

  # いいねする
  def create
    @train = Train.find(params[:train_id])
    @favorite = @train.favorites.new(user_id: current_user.id)
    @favorite.save
    @train.create_notification_favorite!(current_user)
  end

  # いいね外す
  def destroy
    @train = Train.find(params[:train_id])
    favorite = @train.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end

end
