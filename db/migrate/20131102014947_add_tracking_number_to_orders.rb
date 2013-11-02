class AddTrackingNumberToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tracking_number, :string
    remove_column :orders, :has_been_shipped
  end
end
