class AddEncryptedBodyToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :encrypted_body, :text
    remove_column :notes, :body
  end
end
