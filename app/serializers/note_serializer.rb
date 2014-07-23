class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :body

  def body
    if object.encrypted_body
      object.encryptor.decrypt_and_verify(object.encrypted_body)
    end
  end
end
