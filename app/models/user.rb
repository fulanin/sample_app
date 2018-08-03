class User < ApplicationRecord
  attr_accessor :remember_token
  before_save {self.email = self.email.downcase}
  validates :name, presence: true, 
                   length: {maximum: 64}
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, 
                       length: {minimum: 6}
  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers logged in user in the database
  def remember
    self.remember_token = User.new_token

    # remember_token se refere ao que foi definido utilizando attr_acessor
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Does the opposite of remember
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Verifies if the given remember_token matches the user's remember digest
  # Returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    # remember_token refers to the parameter on the function
    # BCrypt::Password.new(remember_digest).is_password?(remember_token)
    BCrypt::Password.new(remember_digest) == remember_token
  end
end
