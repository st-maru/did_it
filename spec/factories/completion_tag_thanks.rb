FactoryBot.define do
    factory :completion_tag_thank do
      summary {Faker::Lorem.sentence}
      name {Faker::Lorem.sentence}
      human {Faker::Lorem.sentence}
      memo {Faker::Lorem.sentence}
      working_day {Faker::Date.between(from: 2.days.ago, to: Date.today)}
      start_time {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now)}
      ending_time {Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)}
    end
end
