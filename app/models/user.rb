class User < ApplicationRecord
  has_secure_password
  validates :password, confirmation: true
  validates :username, uniqueness: true, presence: true
  validates :last_name, :first_name, :password_confirmation, :email, presence: true

  before_create :prepare_full_name

  private

  def prepare_full_name
    if self.middle_name.nil? 
      self.first_name + ' ' + self.last_name
    else
      self.first_name + ' ' + self.middle_name + ' ' + self.last_name
    end
  end
end
