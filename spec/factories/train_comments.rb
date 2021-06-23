FactoryBot.define do
  factory :train_comment do
    comment { Faker::Lorem.characters(number: 20) }
    train
    user
  end
end
