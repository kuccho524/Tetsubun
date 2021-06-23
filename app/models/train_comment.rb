class TrainComment < ApplicationRecord
  # コメントのモデル

  # アソシエーション
  belongs_to :user
  belongs_to :train
  has_many :notifications, dependent: :destroy

  # バリデーション
  validates :comment, length: { maximum: 140 }, presence: true
end
