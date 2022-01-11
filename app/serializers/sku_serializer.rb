class SkuSerializer < ActiveModel::Serializer

  attributes :id, :size, :color, :price, :quantity, :image_url, :hasImage?
  belongs_to :product

  def hasImage?
    if self.object.image.attached?
      return 'image attached' 
    else
      return 'no image'
    end
  end
end
