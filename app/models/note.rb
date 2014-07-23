require 'bcrypt'

class Note < ActiveRecord::Base
  attr_accessor :password, :body
  before_save :encrypt_password, :encrypt_body

  validates :title, :body, :password, presence: true

  def encryptor
    body_secret = OpenSSL::Digest::SHA256.new(password).digest
    ActiveSupport::MessageEncryptor.new(body_secret)
  end

  private

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def encrypt_body
    self.encrypted_body = encryptor.encrypt_and_sign(body)
  end
end
