require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe ".confirmed?" do
    context "when friendship is not confirmed" do
      let(:friendship) { FactoryBot.create(:friendship, confirmed: false) }

      it "returns false" do
        result = described_class.confirmed?(friendship.user, friendship.friend)
        expect(result).to be_falsey
      end
    end

    context "when friendship is confirmed" do
      let(:friendship) { FactoryBot.create(:friendship, confirmed: true) }

      it "returns true" do
        result = described_class.confirmed?(friendship.user, friendship.friend)
        expect(result).to be_truthy
      end
    end
  end

  describe "#confirm" do
    subject(:friendship) { FactoryBot.create(:friendship) }

    it "sets confirmed attribute to true" do
      friendship.confirm
      expect(friendship.confirmed).to be_truthy
    end
  end
end
