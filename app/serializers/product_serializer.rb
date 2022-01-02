class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :quantity

  has_many :skus 
  has_many :categories

  def quantity
    self.skus.count
  end
end
