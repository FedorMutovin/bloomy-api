class AddDeadlineAtToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :deadline_at, :datetime
  end
end
