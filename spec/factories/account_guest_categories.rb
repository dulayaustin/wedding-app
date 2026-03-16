FactoryBot.define do
  factory :account_guest_category do
    association :account
    name { Faker::Lorem.unique.word }
  end
end
