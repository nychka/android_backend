FactoryGirl.define do
  factory :product do
    title_en      'apple'
    title_ua      'яблуко'
    calories      100
    fats          100
    proteins      100
    carbohydrates 100
    image         'apple.png'
    group
  end
end
