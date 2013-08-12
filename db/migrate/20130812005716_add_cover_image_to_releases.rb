class AddCoverImageToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :cover_image, :string
  end
end
