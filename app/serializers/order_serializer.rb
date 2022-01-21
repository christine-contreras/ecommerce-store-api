class OrderSerializer < ActiveModel::Serializer
  attributes :id, :amount, :address, :name, :email, :session_id, :invoice, :status,  :created_at, :updated_at

  belongs_to :user, serializer: OrderUserSerializer
  has_many :selected_items
end
