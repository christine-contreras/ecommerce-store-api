class Category < ApplicationRecord
    has_many :product_categories, dependent: :destroy
    has_many :products, through: :product_categories

    validates :name, {presence: true}
    validates :isActive, {inclusion: { in: [ true, false ] }}

   # grab url of image
    def image_url 
      bucket = S3_BUCKET

      if self.image_key 
        if bucket.object(self.image_key).exists? 
          url = bucket.object(self.image_key).public_url
          return url
        else
          return nil 
        end
      else
        return nil
      end
    end

end
