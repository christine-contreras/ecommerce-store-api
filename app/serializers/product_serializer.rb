class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :quantity, :isActive, :isSlotted, :options

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
       []
    end
  end

  def options
    if self.colors.length > 0
      self.colors.collect do |color|
          sku = self.object.skus.find {|sku| sku.color === color}
          sizes = self.object.skus.collect {|sku| sku.size}.uniq
          {color: color, image_url: sku.image_url, sizes: sizes, price: sku.price}
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


