require 'bcrypt'

class Note < ActiveRecord::Base
  attr_accessor :password, :body
  before_save :encrypt_password

  validates :title, :encrypted_body, :password, presence: true

  private

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end
end
