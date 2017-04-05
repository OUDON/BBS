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
  
  it "is invalid with duplicate [topic_id, in_topic_id]" do
    topic = create(:topic)
    post1 = create(:post, topic: topic, user: topic.user, in_topic_id: 1)
    post2 = build(:post, topic: topic, user: topic.user, in_topic_id: 1)
    post2.valid?
    expect(post2.errors[:in_topic_id]).to include("has already been taken")
  end

  it "sets in_topic_id automatically" do
    topic = create(:topic)
    post1 = create(:post, topic: topic, user: topic.user)
    post2 = create(:post, topic: topic, user: topic.user)
    expect(post2.in_topic_id).to eq 2
  end
end
