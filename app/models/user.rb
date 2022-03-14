class User < ApplicationRecord
  has_secure_password
  validates :password, confirmation: true
  validates :username, uniqueness: true
  validates :last_name, :first_name, :password_confirmation, presence: true
end
