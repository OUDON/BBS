class Topic < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true

  belongs_to :user
  has_many :posts, dependent: :destroy

  scope :ordered_by_updated_at, -> { order(updated_at: :desc) }
  scope :search, ->(query) { where('lower(title) like ?', "%#{ query.downcase }%") }
end
