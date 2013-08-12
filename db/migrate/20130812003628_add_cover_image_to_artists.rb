class AddCoverImageToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :cover_image, :string
  end
end
