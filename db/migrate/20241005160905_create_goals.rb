class CreateGoals < ActiveRecord::Migration[7.2]
  def change
    create_table :goals, id: :uuid do |t|
      t.string :name, null: false
      t.references :user, type: :uuid, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
