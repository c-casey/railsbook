FactoryBot.define do
  factory :comment do
    author
    association :parent, factory: :post
    content { Faker::Quote.matz }
  end
end
