require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the LikesHelper. For example:
#
# describe LikesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe LikesHelper, type: :helper do
  let(:post) { instance_double(Post) }
  let(:user) { instance_double(User) }

  describe "#like_button_text" do
    context "when post is already liked" do
      before do
        allow(post).to receive("liked?").and_return(true)
        allow(post).to receive("likes").and_return([1, 2, 3])
      end

      it "displays unlike button" do
        result = helper.like_button_text(post, user)
        expect(result).to eql("Unlike (3)")
      end
    end

    context "when post is not already liked" do
      before do
        allow(post).to receive("liked?").and_return(false)
        allow(post).to receive("likes").and_return([1, 2, 3, 4, 5, 6, 7])
      end

      it "displays like button" do
        result = helper.like_button_text(post, user)
        expect(result).to eql("Like (7)")
      end
    end
  end

  describe "#select_like_form" do
    context "when post is liked" do
      before do
        allow(post).to receive("liked?").and_return(true)
      end

      it "returns create form path" do
        result = helper.select_like_form(post, user)
        expect(result).to eql("likes/delete_form")
      end
    end

    context "when post isn't liked" do
      before do
        allow(post).to receive("liked?").and_return(false)
      end

      it "returns create form path" do
        result = helper.select_like_form(post, user)
        expect(result).to eql("likes/form")
      end
    end
  end

  describe "#delete_like_path" do
    let(:like) { instance_double(Like) }

    before do
      allow(helper).to receive("find_like").and_return(like)
      allow(like).to receive("id").and_return(47)
    end

    it "returns the correct path" do
      result = helper.delete_like_path(post)
      expect(result).to eql("/likes/47")
    end
  end
end
