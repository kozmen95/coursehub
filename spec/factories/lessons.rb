FactoryBot.define do
  factory :lesson do
    course { nil }
    starts_at { "2025-09-24 12:03:04" }
    ends_at { "2025-09-24 12:03:04" }
    location { "MyString" }
  end
end
