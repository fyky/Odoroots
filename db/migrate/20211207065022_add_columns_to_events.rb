class AddColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :image_id, :string
  end
end
