class AddIsMerchandiseToProducts < ActiveRecord::Migration
  def change
    add_column :orders, :is_merchandise, :boolean
  end
end
