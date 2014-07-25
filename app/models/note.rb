class Note < ActiveRecord::Base
  attr_accessor :password, :body

  validates :title, :encrypted_body, :password_hash, presence: true
end
