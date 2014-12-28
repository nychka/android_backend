class ProductWithEmbeddedGroupSerializer < ActiveModel::Serializer
  attributes :id, :title, :calories, :fats, :proteins, :carbohydrates, :image
  belongs_to :group
end
