class DecryptNoteEncryptedBody
  def self.call(note:, given_password:)
    secret = generate_secret(given_password: given_password)
    message_encryptor = ActiveSupport::MessageEncryptor.new(secret)

    note.body = message_encryptor.decrypt_and_verify(note.encrypted_body)

    note
  end

  private

  def self.generate_secret(given_password:)
    OpenSSL::Digest::SHA256.new(given_password).digest
  end
end
