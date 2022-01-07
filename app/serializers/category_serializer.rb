class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :products_slotted, :isActive
  has_many :products

  def products_slotted
    self.object.products.count
  end
end
