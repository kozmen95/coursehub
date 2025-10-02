FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "password123" }
    role { :student }

    trait :student do
      role { :student }
    end

    trait :instructor do
      role { :instructor }
    end
  end
end
