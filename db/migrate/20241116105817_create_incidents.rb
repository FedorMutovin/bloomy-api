class CreateIncidents < ActiveRecord::Migration[7.2]
  def change
    create_table :incidents, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.text :description
      t.datetime :initiated_at, null: false
      t.integer :impact, null: false, default: 0
      t.timestamps
    end
  end
end
