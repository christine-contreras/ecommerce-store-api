class ProductCategory < ApplicationRecord
  belongs_to :product
  belongs_to :category

  validates :product_id, {presence: true }
  validates :category_id, {presence: true }

  def self.filter_by_product(product_id) 
    self.where(product_id: product_id).all
  end
end
