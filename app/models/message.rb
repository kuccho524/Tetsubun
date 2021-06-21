class Message < ApplicationRecord
  # メッセージ機能のモデル

  # アソシエーション
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  # バリデーション
  validates :message, length: { maximum: 140 }, presence: true
end
