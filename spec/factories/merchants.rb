FactoryBot.define do
  factory :merchant do
    name { Faker::Lorem.words(4) }
  end
end
