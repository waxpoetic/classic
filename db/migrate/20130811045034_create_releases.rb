class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :name
      t.date :released_on
      t.string :catalog_number
      t.references :artist
      t.text :description
      t.text :tracks

      t.timestamps
    end
    add_index :releases, :artist_id
  end
end
