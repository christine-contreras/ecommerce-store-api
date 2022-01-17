class CartSerializer < ActiveModel::Serializer
  attributes :id, :item_count, :total, :shipping

  has_many :selected_items 

  def item_count 
    self.object.selected_items.collect {|item| item.quantity}.sum
  end

  def total 
    self.object.selected_items.collect {|item| item.price}.sum
  end

  def shipping 
    (total.to_i < 100) && (total.to_i != 0) ? '10.0' : '0'
  end
end
