class AddPhotoImageToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :photo_image, :string
  end
end
