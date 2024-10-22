class CreateWishes < ActiveRecord::Migration[7.2]
  def change
    create_table :wishes, id: :uuid do |t|
      t.references :user, foreign_key: true, null: false, type: :uuid
      t.string :title, null: false
      t.text :description
      t.timestamps
    end
  end
end
