class Cart < ApplicationRecord
    has_many :selected_items, dependent: :destroy
end
