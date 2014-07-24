require 'rails_helper'

RSpec.describe NoteAuthenticationService, type: :service do
  let(:note) { Fabricate.build(:note) }
  let(:password) { note.password }
  let(:password_salt) { note.password_salt }

  describe '.authenticate' do
    let(:note) { Fabricate(:note) }

    context 'when provided the correct password' do
      subject { described_class.authenticate(note, password) }

      it { expect(subject).to be(true) }
    end

    context 'when provided the incorrect password' do
      subject { described_class.authenticate(note, 'badpassword') }

      it { expect(subject).to be(false) }
    end
  end

  describe '.hash_password' do
    subject { described_class.hash_password(password, password_salt) }

    it 'returns a hashed version of the password' do
      expect(subject).to eq(BCrypt::Engine.hash_secret(password, password_salt))
    end
  end
end
