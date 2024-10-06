class CreateEventSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :event_schedules, id: :uuid do |t|
      t.references :scheduable, type: :uuid, null: false, polymorphic: true
      t.datetime :scheduled_at, null: false
      t.timestamps
    end
  end
end
