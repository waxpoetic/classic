class AddHasBeenShippedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :has_been_shipped, :boolean, :default => false
  end
end
