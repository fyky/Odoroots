class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :event

  enum permission: { yet: 0, done: 1, not: 2 }
end
