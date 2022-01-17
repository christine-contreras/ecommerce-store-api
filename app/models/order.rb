class Order < ApplicationRecord
    belongs_to :user
    has_many :selected_items, dependent: :destroy

    serialize :address, JSON
    
    validates :status, inclusion: { in: ['Pending', 'Processing', 'Shipped', 'Completed', 'Cancelled']}
    validates :amount, {numericality: true}

end
