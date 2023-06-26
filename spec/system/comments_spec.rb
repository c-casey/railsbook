require "rails_helper"

RSpec.describe "Comments", type: :system do
  before do
    driven_by(:selenium_headless)
  end

  feature "creating a comment" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    before do
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

  feature "deleting a comment" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:post) { create(:post, author: user1) }

    before do
      login_as(user1)
    end

    scenario "belonging to self" do
      comment = Comment.create!(author: user1, parent: post, content: "my comment")
      visit post_path(post.id)
      click_on id: "comment_#{comment.id}_dropdown_button"
      click_on "Delete"
      accept_prompt

      expect(page).not_to have_content("my comment")
    end

    scenario "belonging to another" do
      comment = Comment.create!(author: user2, parent: post, content: "other comment")
      visit post_path(post.id)
      click_on id: "comment_#{comment.id}_dropdown_button"

      expect(page).not_to have_content("Delete")
    end
  end

  feature "updating a comment" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:post) { create(:post, author: user1) }

    before do
      login_as(user1)
    end

    scenario "with new content" do
      comment = create(:comment, parent: post, author: user1)
      visit post_path(post.id)
      click_on id: "comment_#{comment.id}_dropdown_button"
      click_on "Edit"
      expect(page).to have_content(comment.content)

      fill_in "comment_#{comment.id}_update_field", with: "brand new"
      click_on "Update Comment"

      expect(page).to have_content("brand new")
    end

    scenario "with old content" do
      comment = create(:comment, parent: post, author: user1, content: "this is content")
      visit post_path(post.id)
      click_on id: "comment_#{comment.id}_dropdown_button"
      click_on "Edit"
      button = find_button("Update Comment", disabled: true)

      expect(button).to be_truthy
    end

    scenario "with no content" do
      comment = create(:comment, parent: post, author: user1, content: "this is content")
      visit post_path(post.id)
      click_on id: "comment_#{comment.id}_dropdown_button"
      click_on "Edit"
      fill_in "comment_#{comment.id}_update_field", with: ""
      button = find_button("Update Comment", disabled: true)

      expect(button).to be_truthy
    end
  end

  feature "showing a comment" do
    let(:user1) { create(:user) }
    let(:post) { create(:post, author: user1) }

    before do
      login_as(user1)
    end

    scenario "when 3 comments exist on post" do
      comments = create_list(:comment, 3, parent: post, author: user1)
      visit comment_path(comments.first)
      expect(page).to have_content("2 comments hidden.")
      expect(page).to have_link("Show all")
    end

    scenario "when 2 comments exist on post" do
      comments = create_list(:comment, 2, parent: post, author: user1)
      visit comment_path(comments.first)
      expect(page).to have_content("1 comment hidden.")
      expect(page).to have_link("Show all")
    end

    scenario "when it is the only comment on post" do
      comment = create(:comment, parent: post, author: user1)
      visit comment_path(comment)
      expect(page).not_to have_link("Show all")
    end
  end
end
