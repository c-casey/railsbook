require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#friend_requests" do
    subject(:user) { FactoryBot.create(:user) }

    context "when friendship is confirmed" do
      it "doesn't return pending request" do
        FactoryBot.create(:friendship, friend: user, confirmed: true)
        request = user.friend_requests.first
        expect(request).to be_nil
      end
    end

    context "when friendship is uncomfirmed" do
      it "returns pending request" do
        FactoryBot.create(:friendship, friend: user, confirmed: false)
        request = user.friend_requests.first
        expect(request).to be_a(Friendship)
      end
    end
  end

  describe "#friends" do
    subject(:user) { FactoryBot.create(:user) }

    context "when user has added friends" do
      it "returns all the friends", :aggregate_failures do
        FactoryBot.create_list(:friendship, 5, user: user, confirmed: true)
        friends = user.friends
        expect(friends).to all(be_a(User))
        expect(friends.length).to equal(5)
      end
    end

    context "when friends have added user" do
      it "returns all the friends" do
        FactoryBot.create_list(:friendship, 3, friend: user, confirmed: true)
        friends = user.friends
        expect(friends).to all(be_a(User))
        expect(friends.length).to equal(3)
      end
    end
  end
end
