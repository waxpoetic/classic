class CreateProductOrders < ActiveRecord::Migration
  def change
    create_table :product_orders do |t|
      t.references :order
      t.references :product

      t.timestamps
    end
    add_index :product_orders, :order_id
    add_index :product_orders, :product_id
  end
end
