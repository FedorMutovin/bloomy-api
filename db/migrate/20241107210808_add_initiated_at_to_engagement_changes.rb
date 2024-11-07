class AddInitiatedAtToEngagementChanges < ActiveRecord::Migration[7.2]
  def change
    add_column :event_engagement_changes, :initiated_at, :datetime, null: false
  end
end
