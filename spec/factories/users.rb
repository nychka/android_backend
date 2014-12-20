FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'password123'
    password_confirmation 'password123'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
