FactoryBot.define do
  factory :lesson do
    title { "Test Lesson" }
    date { 1.day.from_now }
    location { "Sala 1" }
    association :course
  end
end
