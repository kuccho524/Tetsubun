class Entry < ApplicationRecord

  # DM機能の中間テーブル

  # アソシエーション
  belongs_to :user
  belongs_to :room

end
