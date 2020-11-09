class Addusertomenuitems < ActiveRecord::Migration[6.0]
  def change
    add_column :menu_items, :user_id, :integer
    add_index :menu_items, :user_id
  end
end
