class ChangeNotNullForEngagementChanges < ActiveRecord::Migration[7.2]
  def change
    change_column_null :goal_engagement_changes,  :reason, false
    change_column_null :goal_engagement_changes,  :initiated_at, false
    change_column_null :task_engagement_changes,  :reason, false
    change_column_null :task_engagement_changes,  :initiated_at, false
  end
end
