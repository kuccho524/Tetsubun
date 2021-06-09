class Message < ApplicationRecord

  # メッセージ機能のモデル

  # アソシエーション
  belongs_to :user
  belongs_to :room

  # バリデーション
  validates :message, length: { maximum: 140 }, presence: true
end
