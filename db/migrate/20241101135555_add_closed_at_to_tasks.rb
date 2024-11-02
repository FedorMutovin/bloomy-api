class AddClosedAtToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :closed_at, :datetime
  end
end
