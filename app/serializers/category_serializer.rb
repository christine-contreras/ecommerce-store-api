class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :products_slotted, :isActive, :image_url, :hasImage?
  has_many :products

  def products_slotted
    self.object.products.count
  end

  def hasImage?
    if self.object.image.attached?
      return 'image attached' 
    else
      return 'no image'
    end
  end
end
