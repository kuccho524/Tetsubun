class SearchesController < ApplicationController
  
  # 検索機能のコントローラー

  # 検索結果を表示
  def search
    @trains = Train.looks(params[:search]).page(params[:page]).reverse_order.per(5)
  end

end
