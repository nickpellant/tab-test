require 'rails_helper'

RSpec.describe 'Notes API', type: :request do
  let(:note_attributes) { Fabricate.attributes_for(:note) }
  let(:note_attribute_keys) { %i(title body) }
  let(:note_params) { { note: note_attributes.slice(*note_attribute_keys) } }

  describe 'POST /notes' do
    context 'when passed valid params' do

      before(:each) do
        post '/notes', note_params
      end

      it 'creates a note' do
        expect(Note.where(note_attributes)).to exist
        expect(response.status).to eq(201)
      end
    end

    context 'when passed unprocessable params' do
      let(:note_attributes) { Fabricate.attributes_for(:note, title: '') }

      before(:each) do
        post '/notes', note_params
      end

      it 'does not create a note' do
        expect(Note.where(note_attributes)).to_not exist
        expect(response.status).to eq(422)
      end
    end
  end
end
