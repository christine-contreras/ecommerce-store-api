class Order < ApplicationRecord
    belongs_to :user
    has_many :skus

    serialize :address, JSON
    
    validates :status, inclusion: { in: ['Pending', 'Processing', 'Shipped', 'Completed', 'Cancelled']}
    validates :amount, numericality: true,
              :format => { :with => /^\d{1,6}(\.\d{0,2})?$/ 

end
