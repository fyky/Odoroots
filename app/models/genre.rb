class Genre < ApplicationRecord
  # アソシエーション
  has_many :events, dependent: :destroy
end
