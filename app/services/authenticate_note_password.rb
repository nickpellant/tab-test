class AuthenticateNotePassword
  def self.call(note:, given_password:)
    given_password_hash = hash_given_password(
      given_password: given_password,
      password_salt: note.password_salt
    )

    given_password_hash == note.password_hash
  end

  private

  def self.hash_given_password(given_password:, password_salt:)
    BCrypt::Engine.hash_secret(given_password, password_salt)
  end
end
