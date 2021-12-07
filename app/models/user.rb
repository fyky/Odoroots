class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image
  has_many :events, dependent: :destroy

  def age
    ((Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i)/10000).floor
  end
end
