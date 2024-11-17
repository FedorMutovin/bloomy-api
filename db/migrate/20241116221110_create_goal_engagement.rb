class CreateGoalEngagement < ActiveRecord::Migration[7.2]
  def change
    create_table :goal_engagements, id: :uuid do |t|
      t.references :goal, foreign_key: true, null: false, type: :uuid
      t.integer :value, null: false
      t.timestamps
    end
  end
end
