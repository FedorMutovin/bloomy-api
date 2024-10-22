class AddCompletedToEventSchedules < ActiveRecord::Migration[7.2]
  def change
    add_column :event_schedules, :completed, :boolean, default: false
  end
end
