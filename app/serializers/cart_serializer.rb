class CartSerializer < ActiveModel::Serializer
  attributes :id

  has_many :skus 
end
