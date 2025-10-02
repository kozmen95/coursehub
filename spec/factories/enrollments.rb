FactoryBot.define do
  factory :enrollment do
    association :user
    association :course
    status { :confirmed }
  end
end
