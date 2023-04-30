require 'rails_helper'

RSpec.describe "Likes", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:selenium_headless)
    login_as(user)
  end

  feature "liking" do
    let(:friend) { create(:friendship, user: user, confirmed: true).friend }

    context "an unliked post" do
      scenario "on the timeline" do
        post = create(:post, author: friend)
        visit root_path
        click_on id: "post_#{post.id}_like_button"

        expect(page).to have_button("Unlike (1)")
      end
    end

    context "a liked post" do
      scenario "on the timeline" do
        post = create(:post, author: friend)
        post.likes << create(:like, author: user)
        visit root_path
        click_on "Unlike (1)", id: "post_#{post.id}_like_button"

        expect(page).to have_button("Like (0)")
      end
    end

    context "an unliked comment" do
      scenario "on the timeline" do
        post = create(:post, author: user)
        comment = create(:comment, author: friend, parent: post)
        visit root_path
        click_on id: "comment_#{comment.id}_like_button"

        expect(page).to have_button("Unlike (1)")
      end
    end
  end
end
