class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :members, :cover_photo

  def cover_photo
    object.cover_image.url
  end
end
