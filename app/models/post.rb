class Post < ApplicationRecord
  validates :content, presence: true
  validates :user,    presence: true
  validates :topic,   presence: true

  belongs_to :user
  belongs_to :topic
end
