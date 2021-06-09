class Train < ApplicationRecord

  # 鉄道のモデル

  # アソシエーション
  belongs_to :user
  has_many :train_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # バリデーション
  attachment :train_image, destroy: false
  validates :body, length: { minimum: 3, maximum: 50 }

  # いいね
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 検索方法
  def self.looks(search)
    return none if search.blank?
    if search
      Train.where(['body LIKE ?', "%#{search}%"])
    else
      Train.all
    end
  end

  # いいねの通知
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      train_id: self.id,
      visited_id: self.user_id,
      action: "favorite"
    )
    notification.save if notification.valid?
  end

  #enum
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
    その他: 19
  }

end
