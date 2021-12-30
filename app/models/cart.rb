class Cart < ApplicationRecord
    has_many :skus 
    has_many :products, through: :skus
end
