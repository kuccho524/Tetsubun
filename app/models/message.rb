class Message < ApplicationRecord

  # メッセージ機能のテーブル

  # アソシエーション
  belongs_to :user
  belongs_to :room
end
