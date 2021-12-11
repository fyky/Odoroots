class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id
      t.integer :visited_id
      t.integer :event_id
      t.integer :comment_id
      t.string :action
      t.boolean :is_checked, default: false, null: false

      t.timestamps
    end
  end
end
