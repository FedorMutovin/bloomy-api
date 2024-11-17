class CreateGoalEngagementChanges < ActiveRecord::Migration[7.2]
  def change
    create_table :goal_engagement_changes, id: :uuid do |t|
      t.references :goal_engagement, type: :uuid, null: false, foreign_key: true
      t.integer :last_value, null: false
      t.integer :new_value, null: false

      t.timestamps
    end
  end
end