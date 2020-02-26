class User < ApplicationRecord
  attr_accessor :remember_token
  before_create :create_remember_digest
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, presence: true
  has_secure_password
  has_many :posts

  def self.digest(string)
    return nil if string.nil?

    Digest::SHA1.hexdigest string
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  private

  def create_remember_digest
    self.remember_token = User.new_token
    self.remember_digest = User.digest(remember_token)
  end
end
