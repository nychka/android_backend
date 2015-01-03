FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              'password123'
    password_confirmation 'password123'
    role
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
  factory :admin, class: User do
    email                 { Faker::Internet.email }
    password              'password123'
    password_confirmation 'password123'
    association :role, factory: :admin_role
  end
  factory :manager, class: User do
    email                 { Faker::Internet.email }
    password              'password123'
    password_confirmation 'password123'
    association :role, factory: :manager_role
  end
end
