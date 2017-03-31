require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  let!(:user) { create(:user) }

  scenario "logs in and out" do
    visit root_path
    click_link "Log in"

    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(current_path).to eq root_path
    expect(page).to have_content("#{ user.name }")

    click_link "Log out"
    expect(current_path).to eq root_path
    expect(page).not_to have_content("#{ user.name }")
  end

  context "with logged in user" do
    before :each do
      log_in user
    end

    scenario "can not show the login page" do
      visit login_path
      expect(current_path).to eq root_path
      expect(page).to have_content("You are already logged in")
    end
  end
end
