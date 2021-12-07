class Event < ApplicationRecord
  attachment :image

  # belongs_to :user

  # Event ichiran kara publish ga true no mono wo syutoku suru mesoddo
  # Ex: Event.all -> Event.published
  def self.published
    self.where(publish: true)
  end
end