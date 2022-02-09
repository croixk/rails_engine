FactoryBot.define do
  factory :item do
    name { Faker::Lorem.words(1) }
    description { Faker::Lorem.words(12) }
    unit_price { 1.5 }
    merchant
  end
end
