class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :goal, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.text :description
      t.boolean :completed, null: false, default: false
      t.datetime :completed_at
      t.timestamps
    end
  end
end
