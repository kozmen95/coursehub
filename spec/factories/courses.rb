FactoryBot.define do
  factory :course do
    title { "MyString" }
    description { "MyText" }
    capacity { 1 }
    price_cents { 1 }
    published { false }
    instructor { nil }
  end
end
