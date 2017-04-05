class Post < ApplicationRecord
  validates :content, presence: true
  validates :in_topic_id, presence: true, uniqueness: { scope: :topic_id }
  validates :user,    presence: true
  validates :topic,   presence: true

  belongs_to :user
  belongs_to :topic, touch: true

  scope :ordered_by_updated_at, -> { order(updated_at: :desc) }
  scope :in_topic, ->(topic_id) { where(topic_id: topic_id) }

  before_validation :init_in_order_topic

  def init_in_order_topic
    if new_record?
      self.in_topic_id ||= topic.posts.count + 1 if topic
    end
  end
end
