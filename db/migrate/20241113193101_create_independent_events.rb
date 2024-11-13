class CreateIndependentEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :independent_events, id: :uuid do |t|
      t.references :user, foreign_key: true, null: false, type: :uuid
      t.string :name, null: false
      t.text :description
      t.datetime :occurred_at, null: false
      t.timestamps
    end
  end
end
