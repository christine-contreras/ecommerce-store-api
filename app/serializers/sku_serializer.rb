class SkuSerializer < ActiveModel::Serializer
  attributes :id, :size, :color

  belongs_to :product
  belongs_to :order 
  belongs_to :cart
end
