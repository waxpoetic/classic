class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :members, :cover, :slug

  def cover
    object.cover_image.url
  end

  def slug
    object.name.parameterize
  end
end
