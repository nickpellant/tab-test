class EncryptNotePassword
  def self.call(note:)
    note.password_salt = BCrypt::Engine.generate_salt
    note.password_hash = BCrypt::Engine.hash_secret(
      note.password,
      note.password_salt
    )

    note
  end
end
