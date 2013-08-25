class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :members, :cover, :slug, :photo

  def cover
    object.cover_image.url
  end

  def slug
    object.name.parameterize
  end

  def photo
    object.photo_image.url
  end
end
