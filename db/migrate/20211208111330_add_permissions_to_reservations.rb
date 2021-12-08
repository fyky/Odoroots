class AddPermissionsToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :permission, :integer, default: 0, null: false
  end
end
