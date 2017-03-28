class User < ApplicationRecord
  validates :name,     presence: true, uniqueness: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password

  has_many :topics, dependent: :destroy
  has_many :posts,  dependent: :destroy
end
