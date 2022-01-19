class UserSerializer < ActiveModel::Serializer
  attributes :id, :isAdmin, :email, :first_name, :last_name, :address, :stripe_id

  has_many :orders
end
