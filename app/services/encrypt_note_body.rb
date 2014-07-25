class EncryptNoteBody
  def self.call(note:)
    secret = generate_secret(password: note.password)
    message_encryptor = ActiveSupport::MessageEncryptor.new(secret)

    note.encrypted_body = message_encryptor.encrypt_and_sign(note.body)

    note
  end

  private

  def self.generate_secret(password:)
    OpenSSL::Digest::SHA256.new(password).digest
  end
end
