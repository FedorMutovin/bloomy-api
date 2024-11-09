class CreateEverydayQuotes < ActiveRecord::Migration[7.2]
  def change
    create_table :everyday_quotes, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.text :description, null: false
      t.timestamps
    end
  end
end
