class AddReasonToEngagementChanges < ActiveRecord::Migration[7.2]
  def change
    add_column :goal_engagement_changes,  :reason, :text
    add_column :task_engagement_changes, :reason, :text
  end
end
