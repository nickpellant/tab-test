module Notes::Show
  def show
    @note = Note.find(params[:id])

    note_password_authenticated = AuthenticateNotePassword.call(
      note: @note,
      given_password: params[:password]
    )

    if note_password_authenticated
      @note.password = params[:password]
      show_ok
    else
      show_not_found
    end
  rescue ActiveRecord::RecordNotFound
    show_not_found
  end

  def show_ok
    render json: @note, status: :ok
  end

  def show_not_found
    render json: {}, status: :not_found
  end
end
