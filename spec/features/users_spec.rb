require 'rails_helper'

RSpec.feature 'User management', type: :feature do
  scenario "adds a new user" do
    visit new_user_path

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
