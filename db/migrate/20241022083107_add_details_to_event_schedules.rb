class AddDetailsToEventSchedules < ActiveRecord::Migration[7.2]
  def change
    add_column :event_schedules, :details, :jsonb
  end
end
