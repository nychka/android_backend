FactoryGirl.define do
  factory :role do
    role "user"
  end
  factory :admin_role, class: Role do
    role "admin"
  end
   factory :manager_role, class: Role do
    role "manager"
  end
end
