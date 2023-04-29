FactoryBot.define do
  factory :post do
    author
    content { Faker::Quote.matz }
  end
end
