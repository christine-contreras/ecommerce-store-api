class Product < ApplicationRecord
    has_many :skus
    has_many :product_categories, dependent: :destroy
    has_many :categories, through: :product_categories
    

    validates :title, {presence: true}

    def best_seller 
        if self.categories.find_by(name: 'Best Sellers')
            return true 
        else
            return false
        end
    end

    def new_arrival
        if self.categories.find_by(name: 'New Arrivals')
            return true 
        else
            return false
        end
    end
end
