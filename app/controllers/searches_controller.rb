class SearchesController < ApplicationController
  before_action :authenticate_user!

  # 検索機能のコントローラー

  # 検索結果を表示
  def search
    @range = params[:range]
    if @range == "Train"
      @trains = Train.looks(params[:search]).page(params[:page]).reverse_order.per(7)
    else
      @users = User.looks(params[:search]).page(params[:page]).per(7)
    end
  end
end
