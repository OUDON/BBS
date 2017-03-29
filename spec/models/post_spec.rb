require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid with content and user and topic" do
    expect(build(:post)).to be_valid
  end

  it "is invalid without content" do
    post = build(:post, content: nil)
    expect(post).not_to be_valid
  end

  it "is invalid without topic association" do
    post = build(:post, topic: nil)
    expect(post).not_to be_valid
  end
end
