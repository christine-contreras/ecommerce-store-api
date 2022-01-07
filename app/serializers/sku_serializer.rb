class SkuSerializer < ActiveModel::Serializer

  attributes :id, :size, :color, :price, :quantity, :image
  attributes :id, :size, :color, :price, :quantity
  belongs_to :product


  def image
    return unless self.object.image.attached?
   
    self.object.image.blob.attributes
          .slice('filename', 'byte_size')
          .merge(url: image_url)
          .tap { |attrs| attrs['name'] = attrs.delete('filename') }
  end

  # grab url of image
  def image_url 
    if self.object.image.attached?
      self.object.image.service_url
    end
  end
end
