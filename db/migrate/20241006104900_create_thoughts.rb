class CreateThoughts < ActiveRecord::Migration[7.2]
  def change
    create_table :thoughts, id: :uuid do |t|
      t.text :description, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
