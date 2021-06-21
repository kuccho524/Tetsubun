class Entry < ApplicationRecord
  # DM機能の中間モデル

  # アソシエーション
  belongs_to :user
  belongs_to :room
end
