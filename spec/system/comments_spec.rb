require 'rails_helper'

RSpec.describe "Creating a comment", type: :system do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before do
    driven_by(:selenium_headless)
    login_as(user1)
    post = Post.create!(author: user1, content: "content")
    visit post_path(post.id)
  end

  scenario "with content" do
    fill_in "Write a comment...", with: "my comment"
    click_on "Add Comment"

    expect(page).to have_content("my comment")
  end

  scenario "without content" do
    fill_in "Write a comment...", with: ""
    button = find_button("Add Comment", disabled: true)

    expect(button).to be_truthy
  end

  scenario "without content after previous submission" do
    fill_in "Write a comment...", with: "my comment"
    click_on "Add Comment"

    fill_in "Write a comment...", with: ""
    button = find_button("Add Comment", disabled: true)

    expect(button).to be_truthy
  end
end
