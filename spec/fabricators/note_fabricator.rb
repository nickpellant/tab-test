Fabricator(:note) do
  title { Faker::Lorem.sentence }
  body { Faker::Lorem.paragraph }
  password { Faker::Internet.password }
  password_salt { BCrypt::Engine.generate_salt }
  password_hash do |attrs|
    BCrypt::Engine.hash_secret(attrs[:password], attrs[:password_salt])
  end
end

Fabricator(:note_with_encrypted_body, from: :note) do
  encrypted_body do |attrs|
    secret = OpenSSL::Digest::SHA256.new(attrs[:password]).digest
    message_encryptor = ActiveSupport::MessageEncryptor.new(secret)
    message_encryptor.encrypt_and_sign(attrs[:body])
  end
end
