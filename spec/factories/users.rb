FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              'password123'
    password_confirmation 'password123'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
