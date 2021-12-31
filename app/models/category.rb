class Category < ApplicationRecord
    has_many :product_categories, dependent: :destroy
    has_many :products, through: :product_categories

    validates :name, {presence: true}
    validates :isActive, {presence: true}
end
