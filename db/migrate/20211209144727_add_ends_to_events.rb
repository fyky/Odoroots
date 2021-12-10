class AddEndsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :recruitment, :boolean, default: true, null: false
  end
end
