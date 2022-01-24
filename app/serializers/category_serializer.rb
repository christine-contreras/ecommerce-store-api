class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :products_slotted, :isActive, :image_key, :image_url, :hasImage?
  # attributes :id, :name, :description, :products_slotted, :isActive, :hasImage?
  has_many :products

  def products_slotted
    self.object.products.count
  end

    def hasImage?
    if self.object.image_key
      return 'image attached' 
    else
      return 'no image'
    end
  end

  # def hasImage?
  #   if self.object.image.attached?
  #     return 'image attached' 
  #   else
  #     return 'no image'
  #   end
  # end

end
