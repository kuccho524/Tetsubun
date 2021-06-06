class HomesController < ApplicationController

  # top画面のコントローラー

  # top画面に新着投稿を表示する
  def top
    @train = Train.all.reverse_order
  end

end
