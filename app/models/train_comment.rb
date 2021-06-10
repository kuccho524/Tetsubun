class TrainComment < ApplicationRecord

  # コメントのモデル

  # アソシエーション
  belongs_to :user
  belongs_to :train
  has_many :notifications, dependent: :destroy

  # バリデーション
  validates :comment, length: { maximum: 140 }, presence: true

   # コメントの通知
  def create_notification_train_comment!(current_user, train_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = TrainComment.select(:user_id).where(train_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_train_comment!(current_user, train_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_train_comment!(current_user, train_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_train_comment!(current_user, train_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      train_id: id,
      train_comment_id: train_comment_id,
      visited_id: visited_id,
      action: 'train_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
