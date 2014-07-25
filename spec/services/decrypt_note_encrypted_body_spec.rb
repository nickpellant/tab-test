require 'rails_helper'

RSpec.describe DecryptNoteEncryptedBody, type: :service do
  let!(:note)               { Fabricate(:note_with_encrypted_body) }
  let!(:note_body)          { note.body }
  let(:note_encrypted_body) { note.encrypted_body }
  let(:note_password)       { note.password }

  describe '.call' do
    before(:each) do
      note.body = ''
    end

    subject do
      described_class.call(note: note, given_password: note_password)
    end

    context 'when given_password is valid' do
      it { expect(subject.body).to eq(note_body) }
    end
  end
end
