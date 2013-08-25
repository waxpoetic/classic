class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.decimal :total, default: 0.00
      t.boolean :is_checked_out, default: false
      t.timestamps
    end
    add_index :orders, :user_id
  end
end
