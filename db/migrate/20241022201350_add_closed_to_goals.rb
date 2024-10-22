class AddClosedToGoals < ActiveRecord::Migration[7.2]
  def change
    add_column :goals, :closed, :boolean, default: false
    add_column :goals, :closed_at, :datetime
    add_column :goals, :started_at, :datetime
    remove_column :goals, :completed
    remove_column :goals, :completed_at
  end
end
