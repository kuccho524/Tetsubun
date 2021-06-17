class HomesController < ApplicationController

  # top画面のコントローラー

  # top画面に新着投稿を表示する
  def top
    if user_signed_in?
      @trains_all = Train.includes(:user, :favorites)
      @user = User.find(current_user.id)
      @follow_users = @user.followings
      @trains = @trains_all.where(user_id: @follow_users).order("created_at DESC").page(params[:page]).per(8)
    else
      @train = Train.all.reverse_order
    end
  end

end
