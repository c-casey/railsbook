FactoryBot.define do
  factory :notification do
    sender { nil }
    receiver { nil }
    type { "" }
    link { "MyString" }
  end
end
