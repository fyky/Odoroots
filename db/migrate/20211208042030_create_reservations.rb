class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.text :comment
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
