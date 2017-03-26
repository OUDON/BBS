class User < ApplicationRecord
  validates :name,     presence: true, uniqueness: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
