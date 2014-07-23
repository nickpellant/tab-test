require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  let(:note_attributes) { Fabricate.attributes_for(:note) }
  let(:note_attribute_keys) { %i(title body) }
  let(:note_params) { { note: note_attributes.slice(*note_attribute_keys) } }

  describe 'POST create' do
    context 'when passed valid params' do
      let(:assigned_note) { assigns(:note) }

      before(:each) do
        post :create, note_params
      end

      it { expect(assigned_note).to be_kind_of(Note) }
      it { is_expected.to respond_with(201) }
      it { expect(Note.where(note_attributes)).to exist }
    end

    context 'when passed unprocessable params' do
      let(:note_attributes) { Fabricate.attributes_for(:note, title: '') }
      let(:assigned_note) { assigns(:note) }

      before(:each) do
        post :create, note_params
      end

      it { is_expected.to respond_with(422) }
      it { expect(assigned_note).to be_a_new(Note) }
      it { expect(Note.where(note_attributes)).to_not exist }
    end
  end
end
