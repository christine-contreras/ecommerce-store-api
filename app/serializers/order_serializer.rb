class OrderSerializer < ActiveModel::Serializer
  attributes :id, :amount, :address, :status, :created_at, :updated_at

  # belongs_to :user
  has_many :skus
end
