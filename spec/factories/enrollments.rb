FactoryBot.define do
  factory :enrollment do
    user { nil }
    course { nil }
    status { 1 }
    note { "MyText" }
  end
end
