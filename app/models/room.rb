class Room < ApplicationRecord
  # チャットルームのモデル

  # アソシエーション
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries
  has_many :notifications, dependent: :destroy
end
