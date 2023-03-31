FactoryBot.define do
  factory :user, aliases: %i[author friend] do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
