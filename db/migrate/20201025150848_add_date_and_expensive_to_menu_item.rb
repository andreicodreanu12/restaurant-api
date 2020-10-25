class AddDateAndExpensiveToMenuItem < ActiveRecord::Migration[6.0]
  def change
    add_column :menu_items, :introduced_at, :datetime
    add_column :menu_items, :is_expensive, :boolean
  end
end
