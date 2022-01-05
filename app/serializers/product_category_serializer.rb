class ProductCategorySerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :category
  belongs_to :product
end
