class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :address_detail, null: false
      t.date :date, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.text :introduction, null: false
      t.text :requirement, null: false
      t.date :deadline, null: false
      t.string :belongings, null: false
      t.string :meeting_place, null: false
      t.text :attention

      t.timestamps
    end
  end
end
