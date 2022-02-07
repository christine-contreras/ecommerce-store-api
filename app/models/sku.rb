class Sku < ApplicationRecord
  belongs_to :product
  has_many :selected_items, dependent: :destroy

  validates :size, {presence: true }
  validates :color, {presence: true }
  validates :price, {presence: true, numericality: true}

   # grab url of image
  #  def image_url 
  #   bucket = S3_BUCKET

  #   if self.image_key 
  #     if bucket.object(self.image_key).exists? 
  #       url = "https://freespirit-app-dev.s3.us-east-2.amazonaws.com/#{self.image_key}"
  #       # url = bucket.object(self.image_key).public_url
  #       return url
  #     else
  #       return 'https://freespirit-app-dev.s3.us-east-2.amazonaws.com/product-placeholder.jpg' 
  #     end
  #   else
  #     return 'https://freespirit-app-dev.s3.us-east-2.amazonaws.com/product-placeholder.jpg'
  #   end
  # end

    # grab url of image
    def image_url 

      if self.image_key 
        url = "https://freespirit-app-dev.s3.us-east-2.amazonaws.com/#{self.image_key}"
        return url
      else
        return 'https://freespirit-app-dev.s3.us-east-2.amazonaws.com/product-placeholder.jpg' 
      end

    end

end
