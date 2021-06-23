FactoryBot.define do
  factory :messages do
    message { Faker::Lorem.characters(number: 20) }
    user
    room
  end
end
