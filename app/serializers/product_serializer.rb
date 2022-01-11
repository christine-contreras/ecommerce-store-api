class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :quantity, :isActive, :isSlotted

  has_many :skus 
  has_many :categories

  def quantity
    self.object.skus.count
  end

  def isActive
    count = self.quantity
    count == 0 ? 'inactive' : 'active'
  end

  def isSlotted
    if self.object.categories.length >= 1
      return 'yes' 
    else
      return 'no'
    end
  end
end
