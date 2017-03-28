require 'rails_helper'

RSpec.feature 'User', type: :feature do
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

  context "with logged in user" do
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
  end
end
