class ReleaseSerializer < ActiveModel::Serializer
  attributes :id, :name, :released_on, :catalog_number, :description, :tracks
  has_one :artist
end
