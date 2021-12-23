class User < ApplicationRecord
    has_secure_password 
    validates :email, {presence: true, uniqueness: true}
    serialize :address, JSON
    
end
