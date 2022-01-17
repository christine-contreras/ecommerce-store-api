class SelectedItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price

  belongs_to :cart 
  belongs_to :order 
  belongs_to :sku, serializer: CartSkuSerializer
end
