class Cart < ApplicationRecord
    has_many :selected_items, dependent: :destroy
    # has_many :products, through: :skus
end
