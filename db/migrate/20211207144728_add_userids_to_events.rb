class AddUseridsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :user_id, :integer
    add_column :events, :genre_id, :integer
  end
end
