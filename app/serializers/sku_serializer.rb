class SkuSerializer < ActiveModel::Serializer

  attributes :id, :size, :color, :price, :quantity, :image_url, :hasImage?
  belongs_to :product


  # # grab url of image
  def image_url 
    if self.object.image.attached?
      self.object.image.url
    end
  end


  def hasImage?
    if self.object.image.attached?
      return 'image attached' 
    else
      return 'no image'
    end
  end
end
