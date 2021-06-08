class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ユーザのモデル

  # アソシエーション
  has_many :trains, dependent: :destroy
  has_many :train_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries

  # フォロー機能のアソシエーション
  # 自分がフォローされる側の関係性
  has_many :passive_of_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  # 自分がフォローする側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # 自分をフォローしている人
  has_many :followers, through: :passive_of_relationships, source: :follower
  # 自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  # 通知機能のアソシエーション
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  # フォローする
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォロー外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか
  def following?(user)
    followings.include?(user)
  end

  # バリデーション
  validates :name, presence: true
  validates :introduction, length: { maximum: 50 }
  attachment :profile_image, destroy: false
end
