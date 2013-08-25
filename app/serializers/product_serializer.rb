class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :file, :license, :price
  has_one :release
end
