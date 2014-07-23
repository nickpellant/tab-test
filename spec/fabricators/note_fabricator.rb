Fabricator(:note) do
  title { Faker::Lorem.sentence }
  body { Faker::Lorem.paragraph }
  password { Faker::Internet.password }
  password_salt { BCrypt::Engine.generate_salt }
  password_hash do |attrs|
    BCrypt::Engine.hash_secret(attrs[:password], attrs[:password_salt])
  end
end
