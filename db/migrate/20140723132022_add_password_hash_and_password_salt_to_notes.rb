class AddPasswordHashAndPasswordSaltToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :password_hash, :string
    add_column :notes, :password_salt, :string
  end
end
