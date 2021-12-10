class Event < ApplicationRecord
  attachment :image

  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :comments, dependent: :destroy


  # イベント一覧（publishがtrueのものを取得するメソッド
  # Event.all -> Event.published
  def self.published
    self.where(publish: true)
  end

  def self.search(keyword)
    where(["name like? OR address like?", "%#{keyword}%", "%#{keyword}%"])
  end

end