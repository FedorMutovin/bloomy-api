class RemoveEventsEngagementChanges < ActiveRecord::Migration[7.2]
  def change
    drop_table :event_engagement_changes
  end
end
