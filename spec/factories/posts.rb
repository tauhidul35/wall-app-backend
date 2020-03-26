FactoryBot.define do
  factory :post do
    message { Faker::Lorem.paragraph }
  end
end
