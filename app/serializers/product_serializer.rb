class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :quantity

  has_many :skus 

  def quantity
    self.skus.count
  end
end
