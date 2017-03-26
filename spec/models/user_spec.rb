require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with name and password" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without name" do
    user = build(:user, name: nil) 
    expect(user).not_to be_valid
  end

  it "is invalid without password" do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it "is valid when the length of name is 20" do
    user = build(:user, name: "a" * 20)
    expect(user).to be_valid
  end

  it "is invalid when the name is too long" do
    user = build(:user, name: "a" * 21)
    expect(user).not_to be_valid
  end

  it "is valid when the length of password is 6" do
    user = build(:user, name: "a" * 6)
    expect(user).to be_valid
  end

  it "is invalid when the password is too short" do
    user = build(:user, password: "a" * 5)
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate name" do
    create(:user, name: "andrew")
    user = build(:user, name: "andrew")
    expect(user).not_to be_valid
  end
end
