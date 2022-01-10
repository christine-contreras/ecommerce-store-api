class SkuSerializer < ActiveModel::Serializer

  # attributes :id, :size, :color, :price, :quantity, :image, :hasImage?
  # attributes :id, :size, :color, :price, :quantity
  attributes :id, :size, :color, :price, :quantity, :image_url, :hasImage?
  belongs_to :product


  # def image
  #   return unless self.object.image.attached?
   
  #   self.object.image.blob.attributes
  #         .slice('filename', 'byte_size')
  #         .merge(url: image_url)
  #         .tap { |attrs| attrs['name'] = attrs.delete('filename') }
  # end

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
