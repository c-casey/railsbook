FactoryBot.define do
  factory :user, aliases: %i[author friend sender receiver] do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
