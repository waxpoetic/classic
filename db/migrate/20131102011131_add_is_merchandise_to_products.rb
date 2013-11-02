class AddIsMerchandiseToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_merchandise, :null => false
  end
end
