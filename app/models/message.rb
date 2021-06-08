class Message < ApplicationRecord

  # メッセージ機能のモデル

  # アソシエーション
  belongs_to :user
  belongs_to :room
end
