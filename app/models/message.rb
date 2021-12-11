class Message < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :room

  has_many :notifications, dependent: :destroy
end
