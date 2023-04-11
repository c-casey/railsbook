FactoryBot.define do
  factory :user, aliases: %i[author friend sender receiver] do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
