FactoryBot.define do
  factory :task do
    name {Faker::Lorem.sentence}
    goal {Faker::Lorem.sentence}
    association :user 
  end
end
