class Train < ApplicationRecord
  # 鉄道のモデル

  # アソシエーション
  belongs_to :user
  has_many :train_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # バリデーション
  attachment :train_image, destroy: false
  validates :body, length: { minimum: 3, maximum: 50 }, presence: true
  validates :train_image, presence: true

  # いいね
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 検索方法
  def self.looks(search)
    if search
      Train.where(['body LIKE ?', "%#{search}%"])
    else
      Train.all
    end
  end

  # いいねの通知
  def create_notification_favorite!(current_user)
    # 既にいいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and train_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        train_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済とする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメントの通知
  def create_notification_train_comment!(current_user, train_comment_id)
    # 自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = TrainComment.select(:user_id).where(train_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_train_comment!(current_user, train_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_train_comment!(current_user, train_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_train_comment!(current_user, train_comment_id, visited_id)
    # コメントは複数回することが考えられるため、一つの投稿に複数回通知する。
    notification = current_user.active_notifications.new(
      train_id: id,
      train_comment_id: train_comment_id,
      visited_id: visited_id,
      action: 'train_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済とする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # enum
  enum line: {
    JR: 0,
    阪急: 1,
    京阪: 2,
    近鉄: 3,
    南海: 4,
    阪神: 5,
    山陽: 6,
    神鉄: 7,
    東武: 8,
    西武: 9,
    京急: 10,
    京成: 11,
    東急: 12,
    小田急: 13,
    京王: 14,
    相鉄: 15,
    名鉄: 16,
    西鉄: 17,
    地下鉄: 18,
    その他: 19,
  }
end
