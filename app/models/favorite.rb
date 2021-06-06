class Favorite < ApplicationRecord

  # いいね機能のテーブル

  # アソシエーション
  belongs_to :user
  belongs_to :train

end
