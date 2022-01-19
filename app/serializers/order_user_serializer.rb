class OrderUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :stripe_id
end
