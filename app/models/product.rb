class Product < ApplicationRecord
    has_many :skus
    has_many :product_categories
    has_many :categories, through: :product_categories
    
    validates :title, {presence: true}
end
