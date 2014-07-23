require 'rails_helper'

RSpec.describe NoteSerializer, type: :serializer do
  let(:note_attributes) { Fabricate.attributes_for(:note) }
  let(:note) { Fabricate(:note, note_attributes) }
  let(:note_json) { { id: note.id }.merge(note_attributes) }

  subject { NoteSerializer.new(note) }

  it 'creates special JSON for the API' do
    expect(subject.to_json).to eql({ note: note_json }.to_json)
  end
end
