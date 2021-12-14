class AddSnslinkToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter, :string
    add_column :users, :instagram, :string
    add_column :users, :facebook, :string
    add_column :users, :youtube, :string
  end
end
