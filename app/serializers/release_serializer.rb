class ReleaseSerializer < ActiveModel::Serializer
  attributes :id, :name, :released_on, :catalog_number, :description,
             :tracks, :cover, :catalog_number, :artist_name, :notes
  has_one :artist

  def cover
    object.cover_image.url
  end

  def artist_name
    object.artist.name
  end

  def permalink
    releases_path object
  end
end
