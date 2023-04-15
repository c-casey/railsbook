require 'rails_helper'

RSpec.describe FriendRequestNotification, type: :model do
  describe ".discard_for" do
    let(:friendship) { FactoryBot.create(:friendship) }

    it "deletes appropriate notification" do
      described_class.create(sender: friendship.user,
                             receiver: friendship.friend,
                             link: friendship.id)
      described_class.discard_for(friendship)
      notification_exists = described_class.exists?(link: friendship.id)
      expect(notification_exists).to be_falsey
    end
  end
end
