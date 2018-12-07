class ChangeNickname < ActiveRecord::Migration[5.2]
  def change
    add_column :nicknames, :genitive, :string
    rename_column :nicknames, :text, :accusative
  end
end
