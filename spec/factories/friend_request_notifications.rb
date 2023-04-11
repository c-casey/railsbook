FactoryBot.define do
  factory :friend_request_notification do
    sender
    receiver
    link { create(:friendship, user: sender, friend: receiver).id }
  end
end
