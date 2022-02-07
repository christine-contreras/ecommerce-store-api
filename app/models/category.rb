class Category < ApplicationRecord
    has_many :product_categories, dependent: :destroy
    has_many :products, through: :product_categories

    validates :name, {presence: true}
    validates :isActive, {inclusion: { in: [ true, false ] }}

    # grab url of image
    def image_url 

      if self.image_key 
        url = "https://freespirit-app-dev.s3.us-east-2.amazonaws.com/#{self.image_key}"
        return url
      else
        return nil
      end

    end

end
