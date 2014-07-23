class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)

    if @note.save
      create_created
    else
      create_unprocessable_entity
    end
  end

  def create_created
    render json: @note, status: :created
  end

  def create_unprocessable_entity
    render json: @note, status: :unprocessable_entity
  end

private

  def note_params
    params.require(:note).permit(:title, :body)
  end
end
