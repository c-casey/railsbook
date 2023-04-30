require 'rails_helper'

RSpec.describe "Posts", type: :system do
  before do
    driven_by(:selenium_headless)
  end

  feature "viewing a post" do
    let(:user) { create(:user) }

    before do
      driven_by(:selenium_headless)
      login_as(user)
    end

    scenario "made by oneself" do
      post = create(:post, author: user)
      visit root_path

      expect(page).to have_content(post.content)
    end

    scenario "made by a friend" do
      friendship = create(:friendship, user: user, confirmed: true)
      post = create(:post, author: friendship.friend)
      visit root_path

      expect(page).to have_content(post.content)
    end

    scenario "made by a stranger" do
      stranger = create(:user)
      post = create(:post, author: stranger)
      visit root_path

      expect(page).not_to have_content(post.content)
    end
  end

  feature "creating a post" do
    before do
      login_as(create(:user))
      visit root_path
    end

    scenario "with content" do
      fill_in "Share what you're thinking", with: "Some post content"
      click_on "Create Post"

      expect(page).to have_content("Some post content")
      expect(page).to have_field("Share what you're thinking")
    end

    scenario "without content" do
      fill_in "Share what you're thinking", with: ""
      button = find_button("Create Post", disabled: true)

      expect(button).to be_truthy
    end

    scenario "entering and then deleting content" do
      fill_in "Share what you're thinking", with: "Some post content"
      button_with_content = find_button("Create Post")
      fill_in "Share what you're thinking", with: "", fill_options: { clear: :backspace }
      button_without_content = find_button("Create Post", disabled: true)
      both_buttons_present = button_with_content && button_without_content

      expect(both_buttons_present).to be_truthy
    end
  end

  feature "updating a post" do
    let(:user) { create(:user) }

    before do
      login_as(user)
    end

    scenario "with new content" do
      post = create(:post, author: user)
      visit root_path
      click_on id: "post_#{post.id}_dropdown_button"
      click_on "Edit"
      fill_in "post_content", currently_with: post.content, with: "brand new"
      click_on "Update Post"

      expect(page).to have_content("brand new")
    end

    scenario "with old content" do
      post = create(:post, author: user)
      visit root_path
      click_on id: "post_#{post.id}_dropdown_button"
      click_on "Edit"
      button = find_button("Update Post", disabled: true)

      expect(button).to be_truthy
    end

    scenario "with no content" do
      post = create(:post, author: user)
      visit root_path
      click_on id: "post_#{post.id}_dropdown_button"
      click_on "Edit"
      fill_in "post_content", currently_with: post.content, with: "", fill_options: { clear: :backspace }
      button = find_button("Update Post", disabled: true)

      expect(button).to be_truthy
    end
  end

  feature "deleting a post" do
    let(:post_owner) { create(:user) }
    let(:user) { create(:user) }
    let(:post) { create(:post, author: post_owner) }

    scenario "owned by user" do
      login_as(post_owner)
      visit post_path(post.id)
      post_content = post.content
      click_on id: "post_#{post.id}_dropdown_button"
      click_on "Delete"
      alert = page.driver.browser.switch_to.alert
      alert.accept
      visit post_path(post.id)

      expect(page).not_to have_content(post_content)
    end

    scenario "not owned by user" do
      login_as(user)
      visit post_path(post.id)
      click_on id: "post_#{post.id}_dropdown_button"

      expect(page).to have_link("Permalink")
      expect(page).not_to have_link("Delete")
    end
  end
end
