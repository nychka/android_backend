class ProductSerializer < ActiveModel::Serializer
  @@current_locale = I18n.locale
  attributes :id, :title, :calories, :fats, :proteins, :carbohydrates, :image, :group_id, :owner

  def title
    translation = object.title.translation[current_locale]
    translation.empty? ? object.title.translation[I18n.default_locale] : translation
  end
  def current_locale
    @@current_locale
  end
  def self.set_current_locale=(locale)
    @@current_locale = locale
  end
end
