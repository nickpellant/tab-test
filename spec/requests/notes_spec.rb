require 'rails_helper'

RSpec.describe 'Notes API', type: :request do
  let(:note_attributes) { Fabricate.attributes_for(:note) }
  let(:note_attribute_keys) { %i(title body password) }

  let(:note_encrypted_attributes) do
    note_attributes.slice(*note_encrypted_attribute_keys)
  end
  let(:note_encrypted_attribute_keys) { %i(title encrypted_body) }

  let(:note_params) { note_attributes.slice(*note_attribute_keys) }

  describe 'POST /notes' do
    context 'when passed valid params' do

      before(:each) do
        post '/notes', note: note_params
      end

      it 'creates a note' do
        expect(Note.where(note_encrypted_attributes)).to exist
        expect(response.status).to eq(201)
      end
    end

    context 'when passed unprocessable params' do
      let(:note_attributes) { Fabricate.attributes_for(:note, title: '') }

      before(:each) do
        post '/notes', note: note_params
      end

      it 'does not create a note' do
        expect(Note.where(note_encrypted_attributes)).to_not exist
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET /notes/:id' do
    context 'when passed a valid record id' do
      let(:note) { Fabricate(:note_with_encrypted_body, note_attributes) }
      let(:note_serializer) { NoteSerializer.new(note) }

      before(:each) do
        get "/notes/#{note.id}", { password: note.password }
      end

      it 'returns the requested note' do
        expect(response.status).to eq(200)

        expect(response.body).to eql(note_serializer.to_json)
      end
    end

    context 'when passed an invalid record id' do
      before(:each) do
        get '/notes/1'
      end

      it 'responds with a 404' do
        expect(response.status).to eq(404)

        expect(response.body).to eql('{}')
      end
    end

    context 'when passed an invalid password' do
      let(:note) { Fabricate(:note_with_encrypted_body, note_attributes) }
      let(:note_serializer) { NoteSerializer.new(note) }

      before(:each) do
        get "/notes/#{note.id}", { password: 'password' }
      end

      it 'responds with a 404' do
        expect(response.status).to eq(404)

        expect(response.body).to eql('{}')
      end
    end
  end
end
