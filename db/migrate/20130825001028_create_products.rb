class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :file
      t.string :license
      t.decimal :price
      t.references :release

      t.timestamps
    end
    add_index :products, :release_id
  end
end
