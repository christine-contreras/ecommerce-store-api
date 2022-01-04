class SkuSerializer < ActiveModel::Serializer
  attributes :id, :size, :color, :price, :quantity, :image

  belongs_to :product
end
