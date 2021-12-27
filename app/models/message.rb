class Message < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :room

  has_many :notifications, dependent: :destroy

  # バリデーション
  validates :body, presence: true

  after_create_commit { MessageBroadcastJob.perform_later self }

end
