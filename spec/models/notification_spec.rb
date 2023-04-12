require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe ".create_and_send" do
    let(:friendship) { FactoryBot.create(:friendship) }
    subject(:notification) do
      described_class.create_and_send(sender: friendship.user,
                                      receiver: friendship.friend,
                                      link: friendship.id,
                                      type: Notification)
    end

    it "creates the appropriate notification type" do
      expect(notification).to be_a(Notification)
    end

    it "makes accessible the relevant friendship" do
      friendship = Friendship.find(notification.link)
      user_identity_p = friendship.user == notification.sender
      expect(user_identity_p).to be_truthy
    end
  end
end
