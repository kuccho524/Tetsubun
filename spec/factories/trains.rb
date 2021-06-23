FactoryBot.define do
  factory :train do
    body { Faker::Lorem.characters(number: 20) }
    user
  end
end
