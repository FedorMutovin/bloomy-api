class CreateEventEngagementChanges < ActiveRecord::Migration[7.2]
  def change
    create_table :event_engagement_changes, id: :uuid do |t|
      t.references :target, type: :uuid, null: false, polymorphic: true
      t.integer :value, null: false
      t.text :reason, null: false
      t.timestamps
    end
  end
end
