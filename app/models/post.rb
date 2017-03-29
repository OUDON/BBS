class Post < ApplicationRecord
  validates :content, presence: true
  validates :in_topic_id, presence: true, uniqueness: { scope: :topic_id }
  validates :user,    presence: true
  validates :topic,   presence: true

  belongs_to :user
  belongs_to :topic, touch: true

  scope :in_topic, ->(topic_id) { where(topic_id: topic_id) }
end
