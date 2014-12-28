class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :calories, :fats, :proteins, :carbohydrates, :image, :group_id
end
