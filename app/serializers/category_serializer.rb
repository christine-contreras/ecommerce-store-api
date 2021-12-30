class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :products_slotted, :status
  has_many :products

  def products_slotted
    self.products.count
  end
end
