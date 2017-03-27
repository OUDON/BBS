require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  before :each do
    @user = create(:user)
  end

  scenario "logs in and out" do
    visit root_path
    click_link "Log in"

    fill_in "Name", with: @user.name
    fill_in "Password", with: @user.password
    click_button "Log in"

    expect(current_path).to eq root_path
    expect(page).to have_content("Logged in as #{ @user.name }")

    click_link "Log out"
    expect(current_path).to eq root_path
    expect(page).not_to have_content("Logged in as #{ @user.name }")
  end
end
