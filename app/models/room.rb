class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy
  # has_many :users

  has_many :notifications, dependent: :destroy
end
