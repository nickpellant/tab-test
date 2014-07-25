module Notes::Create
  def create
    @note = Note.new(note_params)
    @note = EncryptNoteBody.call(note: @note)

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
end
