require 'rails_helper'

RSpec.describe NoteSerializer, type: :serializer do
  let(:note_attributes) { Fabricate.attributes_for(:note) }
  let(:note_attribute_keys) { %i(title body) }
  let(:note_sliced_attributes) { note_attributes.slice(*note_attribute_keys) }

  let(:note) { Fabricate(:note_with_encrypted_body, note_sliced_attributes) }
  let(:note_json) { { id: note.id }.merge(note_sliced_attributes) }

  subject { NoteSerializer.new(note) }

  it 'creates special JSON for the API' do
    expect(subject.to_json).to eql({ note: note_json }.to_json)
  end
end
