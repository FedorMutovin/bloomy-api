class CreateTaskEngagements < ActiveRecord::Migration[7.2]
  def change
    create_table :task_engagements, id: :uuid do |t|
      t.references :task, foreign_key: true, null: false, type: :uuid
      t.integer :value, null: false

      t.timestamps
    end
  end
end
