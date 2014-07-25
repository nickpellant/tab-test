require 'rails_helper'

RSpec.describe AuthenticateNotePassword, type: :service do
  let(:note)               { Fabricate(:note_with_encrypted_body) }
  let(:note_password)      { note.password }
  let(:note_password_hash) { note.password_hash }

  describe '.call' do
    subject do
      described_class.call(note: note, given_password: note_password)
    end

    context 'when given_password is valid' do
      it { expect(subject).to be(true) }
    end

    context 'when given_password is invalid' do
      let(:note_password) { 'invalid_password' }

      it { expect(subject).to be(false) }
    end
  end

  describe '.hash_given_password' do
    subject do
      described_class.hash_given_password(
        given_password: note_password,
        password_salt: note.password_salt
      )
    end

    it 'hashes and returns given_password' do
      expect(subject).to eq(note_password_hash)
    end
  end
end
