class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :event

  has_many :notifications, dependent: :destroy

  enum permission: { yet: 0, done: 1, not: 2 }

    # イベント参加承認通知の設定をここに記述
  def update_notification_permission!(current_user)
    notification = current_user.active_notifications.new(
      event_id: event_id,
      reservation_id: id,
      visited_id: user_id,
      action:"permission"
    )
    notification.save if notification.valid?
  end

end