json.array!(@products) do |product|
  json.extract! product, :id, :title, :calories, :fats, :proteins, :carbohydrates, :image
  json.url product_url(product, format: :json)
end
