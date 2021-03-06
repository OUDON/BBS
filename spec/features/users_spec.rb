require 'rails_helper'

RSpec.feature 'User management', type: :feature do
  scenario "adds a new user" do
    visit root_path
    click_link "Sign up"

    expect {
      fill_in "Name", with: "oudon"
      fill_in "Password", with: "secret123"
      fill_in "Confirmation", with: "secret123"
      click_button "Register"
    }.to change(User, :count).by(1)

    expect(current_path).to eq user_path(User.last)
    expect(page).to have_content("Your registration is successful")
  end
end

RSpec.feature "Logged in user" do
  before :each do
    @user = create(:user)
    log_in @user
  end

  scenario "updates a user profile" do
    visit root_path
    click_link "Settings"
    
    fill_in "Name", with: "updated user name"
    fill_in "Password", with: @user.password
    fill_in "Confirmation", with: @user.password
    click_button "Update"

    expect(current_path).to eq user_path(@user)
    expect(page).to have_content("Profile updated")
    expect(page).to have_content("updated user name")
  end

  scenario "can not update other user's profile" do
    other_user = create(:user, name: "andrew")
    visit edit_user_path(other_user)
    expect(current_path).to eq root_path
    expect(page).to have_content("Permission denied")
  end

  scenario "creates new topics" do
    visit root_path

    expect {
      fill_in "Topic Title", with: "Lorem ipsum"
      click_button "Create"
    }.to change(Topic, :count).by(1)

    expect(current_path).to eq topic_path(Topic.last)
    expect(page).to have_content("Your topic is created")
  end

  scenario "can not create invalid topics" do
    visit root_path

    expect {
      click_button "Create"
    }.not_to change(Topic, :count)

    expect(current_path).to eq topics_path
    expect(page).to have_content("can't be blank")
  end

  context "with a topic" do
    before :each do
      visit root_path
      fill_in "Topic Title", with: "Lorem ipsum"
      click_button "Create"
    end

    scenario "adds a new post" do
      visit root_path
      click_link "Lorem ipsum"

      expect {
        fill_in "Content", with: "my post"
        click_button "Add"
      }.to change(Post, :count).by(1)

      expect(current_path).to eq topic_path(Topic.last)
      expect(page).to have_content("1: #{ @user.name }")
    end

    scenario "adds a invalid post" do
      visit root_path
      click_link "Lorem ipsum"

      expect {
        click_button "Add"
      }.not_to change(Post, :count)

      expect(current_path).to eq topic_posts_path(Topic.last)
      expect(page).to have_content("can't be blank")
      expect(page).not_to have_content("1: #{ @user.name }")
    end
  end
end
