class Topic < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true

  belongs_to :user
end
