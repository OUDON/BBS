require 'rails_helper'

RSpec.feature "User looking for topics" do
  before :each do
    user = create(:user)
    create(:topic, title: "How to make curry", user: user)
    create(:topic, title: "How to make sushi", user: user)
  end

  scenario "finds the topics" do
    visit root_path
    fill_in "Search topics", with: "curry"
    find("#btn-search").click

    expect(current_path).to eq search_path
    expect(page).to have_content("How to make curry")
    expect(page).not_to have_content("How to make sushi")
  end
end
