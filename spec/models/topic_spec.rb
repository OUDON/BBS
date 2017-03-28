require 'rails_helper'

RSpec.describe Topic, type: :model do
  it "is valid with title and user association" do
    expect(build(:topic)).to be_valid
  end

  it "is invalid without title" do
    topic = build(:topic, title: nil)
    expect(topic).not_to be_valid
  end

  it "is invalid without user association" do
    topic = build(:topic, user: nil)
    expect(topic).not_to be_valid
  end

  it "is invalid with too long title" do
    topic = build(:topic, title: "a" * 51)
    expect(topic).not_to be_valid
  end
end
