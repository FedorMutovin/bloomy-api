class CreateTravels < ActiveRecord::Migration[7.2]
  def change
    create_table :travels, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.text :description
      t.string :destination, null: false
      t.timestamps
    end
  end
end
