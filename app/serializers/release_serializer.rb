class ReleaseSerializer < ActiveModel::Serializer
  attributes :id, :name, :released_on, :catalog_number, :description,
             :tracks, :cover, :catalog_number
  has_one :artist

  def cover
    object.cover_image.url
  end

  def permalink
    releases_path object
  end
end
