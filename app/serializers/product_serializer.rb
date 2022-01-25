class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :quantity, :inStock, :isSlotted, :isActive, :options, :best_seller, :new_arrival

  has_many :skus 
  has_many :categories

  def quantity
    self.object.skus.count
  end

  def inStock
    count = self.quantity
    count == 0 ? 'out of stock' : 'in stock'
  end

  def colors
    if self.quantity > 0
      self.object.skus.collect {|sku| sku.color}.uniq
    else
       []
    end
  end

  def options
    if self.colors.length > 0

      self.colors.collect do |color|
          sku = self.object.skus.find {|sku| sku.color === color}
          sizeInfo = self.object.skus.collect do |sku|
            {size: sku.size, quantity: sku.quantity} if sku.color === color
          end.compact

          {color: color, image_url: sku.image_url, sizes: sizeInfo, price: sku.price}
      end.uniq
    else
      []
    end
  end

  def isSlotted
    if self.object.categories.length >= 1
      return 'yes' 
    else
      return 'no'
    end
  end
end


