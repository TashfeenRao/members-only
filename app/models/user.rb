class User < ApplicationRecord
    attr_accessor :remember_token

    before_save {self.email = email.downcase}
    validates :name, presence: true, length: {maximum: 30}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255},
               format: {with:VALID_EMAIL_REGEX },
               uniqueness: {case_sensitive: false}
    validates :password, length: {minimum: 6}, presence: true
    has_secure_password

    def User.digest(string)
        Digest::SHA1.hexdigest string.to_s
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
      end

    def authenticated(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

end
