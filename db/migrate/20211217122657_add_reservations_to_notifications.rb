class AddReservationsToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :reservation_id, :integer
  end
end
