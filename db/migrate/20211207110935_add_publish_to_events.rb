class AddPublishToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :publish, :boolean, default: false, null: false
  end
end
