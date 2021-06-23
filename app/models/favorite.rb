class Favorite < ApplicationRecord
  # いいね機能のモデル

  # アソシエーション
  belongs_to :user
  belongs_to :train
end
