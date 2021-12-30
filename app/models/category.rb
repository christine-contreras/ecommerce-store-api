class Category < ApplicationRecord
    has_many :product_categories
    has_many :products, through: :product_categories

    validates :name, {presence: true}
    validates :status, inclusion: { in: ['Inactive', 'Active']}
end
