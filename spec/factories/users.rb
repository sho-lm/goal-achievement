FactoryBot.define do
  factory :sally, class: User do
    account_id { "sally" }
    name { "sally" }
    password { "1234aA" }
    is_admin { false }
    is_private { false }
  end
  
  factory :tom, class: User do
    account_id { "tom" }
    name { "tom" }
    password { "1234aA" }
    is_admin { false }
    is_private { false }
  end
end