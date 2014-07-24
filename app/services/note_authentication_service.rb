class NoteAuthenticationService
  def self.authenticate(note, password)
    hash_password(password, note.password_salt) == note.password_hash
  end

  private

  def self.hash_password(password, password_salt)
    BCrypt::Engine.hash_secret(password, password_salt)
  end
end
