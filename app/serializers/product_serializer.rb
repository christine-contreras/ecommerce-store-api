class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :quantity, :isActive, :isSlotted, :prices, :colors, :sizes, :images

  has_many :skus 
  has_many :categories

  def quantity
    self.object.skus.count
  end

  def isActive
    count = self.quantity
    count == 0 ? 'inactive' : 'active'
  end

  def colors
    if self.quantity > 0
      self.object.skus.collect {|sku| sku.color}.uniq
    else
      return []
    end
  end

  def sizes
    if self.quantity > 0
      self.object.skus.collect {|sku| sku.size}.uniq
    else
      return []
    end
  end

  def images
    if self.colors.length > 0
      self.colors.collect do |color|
          sku = self.object.skus.find {|sku| sku.color === color}
          return {color: color, image: sku.image_url}
      end
    else
      return []
    end
  end

  def prices
    if self.quantity > 0
      self.object.skus.collect {|sku| sku.price}.uniq
    else
      return []
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
