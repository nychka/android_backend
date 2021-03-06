FactoryGirl.define do
  factory :product do
    title_en      { Faker::Lorem.word }
    #title_ua      { Faker::Lorem.word }
    calories      { rand(100) }
    fats          { rand(100) }
    proteins      { rand(100) }
    carbohydrates { rand(100) }
    image         { "#{Faker::Lorem.word}.png" }
    group
    user
  end
   factory :system_product, class: Product do
    title_en      { Faker::Lorem.word }
    #title_ua      { Faker::Lorem.word }
    calories      { rand(100) }
    fats          { rand(100) }
    proteins      { rand(100) }
    carbohydrates { rand(100) }
    image         { "#{Faker::Lorem.word}.png" }
    group
    user_id       0
  end
end
