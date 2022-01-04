class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :quantity, :isActive

  has_many :skus 
  has_many :categories

  def quantity
    self.object.skus.count
  end

  def isActive 
    count = self.quantity
    count == 0 ? 'inactive' : 'active'
  end
end
