class ReleaseSerializer < ActiveModel::Serializer
  attributes :id, :name, :released_on, :catalog_number, :description,
             :tracks, :cover
  has_one :artist

  def cover
    object.cover_image.url
  end
end
