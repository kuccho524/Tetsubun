class TrainComment < ApplicationRecord

  # コメントのモデル

  # アソシエーション
  belongs_to :user
  belongs_to :train

  # バリデーション
  validates :comment, presence: true

end
