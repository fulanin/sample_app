class User < ApplicationRecord
  before_save {self.email = self.email.downcase}
  validates :name, presence: true, 
                   length: {maximum: 64}
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i},
                    uniqueness: {case_sensitive: false}
  has_secure_password
end
