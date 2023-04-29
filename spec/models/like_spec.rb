require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "#likeable" do
    context "when likeable is a Post" do
      let(:author) { FactoryBot.create(:user) }
      let(:likeable) { FactoryBot.create(:post) }
      subject(:like) { Like.new(author: author, likeable: likeable) }

      it "returns the Post" do
        result = like.likeable
        expect(result).to be_a(Post)
      end
    end

    context "when likeable is a Comment" do
      let(:author) { FactoryBot.create(:user) }
      let(:likeable) { FactoryBot.create(:comment) }
      subject(:like) { Like.new(author: author, likeable: likeable) }

      it "returns the Comment" do
        result = like.likeable
        expect(result).to be_a(Comment)
      end
    end
  end
end
