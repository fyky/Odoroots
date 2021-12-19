class Event < ApplicationRecord
  attachment :image

  # アソシエーション
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :genre

  has_many :notifications, dependent: :destroy

  # バリデーション
  validates :name, presence: true
  validates :address, presence: true
  validates :address_detail, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :introduction, presence: true
  validates :requirement, presence: true
  validates :deadline, presence: true
  validates :belongings, presence: true
  validates :meeting_place, presence: true
  validates :number, presence: true
  validates :attention, presence: true


  # 住所を一行で取得
  def full_address
    address + address_detail
  end

  def event_date
    self.date
  end

  # 地図を緯度と経度で取得
  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?&&:address_detail_changed?


  # イベント一覧（publishがtrueのものを取得するメソッド
  # Event.all -> Event.published
  def self.published
    self.where(publish: true)
  end

  def self.search(keyword)
    where(["name like? OR address like?", "%#{keyword}%", "%#{keyword}%"])
  end

  # def self.search(method)
  # self.published.where(['date > ?', Date.current])
  # end

  def favorited_by?(user)
    unless user==nil
      favorites.where(user_id: user.id).exists?
    end
  end

  # 通知：いいね
  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and event_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        event_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知しない（通知済みとする）
      if notification.visitor_id == notification.visited_id
        notification.is_checked = true
      end
      notification.save if notification.valid?
    end
  end

  # 通知：コメント
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(event_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      event_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # イベント仮予約通知の設定をここに記述
  def create_notification_reservation!(current_user, reservation_id)
    notification = current_user.active_notifications.new(
      event_id: id,
      reservation_id: reservation_id,
      visited_id: user_id,
      action:"reservation"
    )
    notification.save if notification.valid?
  end



end