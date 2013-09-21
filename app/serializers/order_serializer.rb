class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total, :is_checked_out
  has_one :user
  has_many :products
end
