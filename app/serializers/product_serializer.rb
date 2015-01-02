class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :calories, :fats, :proteins, :carbohydrates, :image, :group_id, :owner

  def title
    translation = object.title.translation[I18n.locale]
    translation.empty? ? object.title.translation[I18n.default_locale] : translation
  end
end
