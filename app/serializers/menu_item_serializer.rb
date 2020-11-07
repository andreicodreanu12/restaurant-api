class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :introduced_at, :is_expensive
end
