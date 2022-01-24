class SkuSerializer < ActiveModel::Serializer

  attributes :id, :size, :color, :price, :quantity, :image_key, :image_url, :hasImage?
  belongs_to :product

  def hasImage?
    if self.object.image_key
      return 'image attached' 
    else
      return 'no image'
    end
  end
end
