class AddNotesToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :notes, :text
  end
end
