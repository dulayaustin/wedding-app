FactoryBot.define do
  factory :guest_category do
    association :account
    name { Faker::Lorem.unique.word }
  end
end
