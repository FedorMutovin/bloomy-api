class RemoveCompletedFromTasks < ActiveRecord::Migration[7.2]
  def change
    remove_column :tasks, :completed, :boolean
    remove_column :tasks, :completed_at, :datetime
  end
end
