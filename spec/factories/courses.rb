FactoryBot.define do
  factory :course do
    title { "Test Course" }
    description { "Opis kursu" }
    capacity { 10 }
    price_cents { 1000 }
    association :instructor, factory: :user, role: :instructor
  end
end
