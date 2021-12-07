class Event < ApplicationRecord
  attachment :image

  belongs_to :user

  # イベント一覧（publishがtrueのものを取得するメソッド
  # Event.all -> Event.published
  def self.published
    self.where(publish: true)
  end
end