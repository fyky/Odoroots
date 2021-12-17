class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :event

  has_many :notifications, dependent: :destroy

  enum permission: { yet: 0, done: 1, not: 2 }
end
