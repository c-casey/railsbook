FactoryBot.define do
  factory :like do
    author
    association :likeable, factory: :post
  end
end
