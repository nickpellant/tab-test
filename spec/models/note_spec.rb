require 'rails_helper'

RSpec.describe Note, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:encrypted_body) }

  describe '#save' do
    let(:note) { Fabricate.build(:note_with_encrypted_body) }

    after(:each) do
      note.save
    end
  end
end
