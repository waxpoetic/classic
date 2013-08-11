class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :members
end
