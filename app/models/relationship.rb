class Relationship < ApplicationRecord
  # フォロー機能の中間モデル

  # アソシエーション
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
