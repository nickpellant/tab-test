class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)

    if @note.save
      create_created
    else
      create_unprocessable_entity
    end
  end

  def show
    @note = Note.find(params[:id])
    password_hash = BCrypt::Engine.hash_secret(params[:password], @note.password_salt)

    if @note.password_hash == password_hash
      @note.password = params[:password]
      show_ok
    else
      show_not_found
    end
  rescue ActiveRecord::RecordNotFound
    show_not_found
  end

  def create_created
    render json: @note, status: :created
  end

  def create_unprocessable_entity
    render json: @note, status: :unprocessable_entity
  end

  def show_ok
    render json: @note, status: :ok
  end

  def show_not_found
    render json: {}, status: :not_found
  end

private

  def note_params
    params.require(:note).permit(:title, :body, :password)
  end
end
