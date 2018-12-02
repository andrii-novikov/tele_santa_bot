class CreateWishes < ActiveRecord::Migration[5.2]
  def change
    create_table :wishes do |t|
      t.belongs_to :user, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end
