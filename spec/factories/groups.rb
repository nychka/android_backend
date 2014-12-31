FactoryGirl.define do
  factory :group do
    title_en      { Faker::Lorem.word }
    title_ua      { Faker::Lorem.word }
  end
end
