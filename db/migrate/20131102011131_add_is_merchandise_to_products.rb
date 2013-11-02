class AddIsMerchandiseToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_merchandise, :boolean
  end
end
