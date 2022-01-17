class CartSkuSerializer < ActiveModel::Serializer
  attributes :id, :size, :color, :price, :quantity, :image_url, :product

  def product 
    product = self.object.product 
    {
      id: product.id,
      title: product.title, 
      description: product.description
    }
  end
end
