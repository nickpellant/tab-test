class NotesController < ApplicationController
  include Notes::Create
  include Notes::Show

  private

  def note_params
    params.require(:note).permit(:title, :body, :password)
  end
end
