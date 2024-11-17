class InitiatedAtToEngagementChanges < ActiveRecord::Migration[7.2]
  def change
    add_column :goal_engagement_changes,  :initiated_at, :datetime
    add_column :task_engagement_changes, :initiated_at, :datetime
  end
end
