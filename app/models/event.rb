class Event < ApplicationRecord
  attachment :image

  belongs_to :user
  has_many :reservations, dependent: :destroy

  # イベント一覧（publishがtrueのものを取得するメソッド
  # Event.all -> Event.published
  def self.published
    self.where(publish: true)
  end

  def self.start_time
    start_time.strftime("%I:%M")
  end

  def self.end_time
    end_time.strftime("%I:%M")
  end
end