class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  # アソシエーション
  has_many :events, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :following

  # active_notifications:自分がした通知
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  # passive_notifications:相手がした通知
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy

  # バリデーション
  validates :real_name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :address_detail, presence: true
  validates :phone_number, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :name, presence: true
  validates :introduction, length: { maximum: 30 }



  def date
    Event.date
  end

  def age
    ((Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i)/10000).floor
  end

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end


  # 通知：フォロー
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
