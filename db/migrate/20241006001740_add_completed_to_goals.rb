class AddCompletedToGoals < ActiveRecord::Migration[7.2]
  def change
    add_column :goals, :completed, :boolean, default: false, null: false
    add_column :goals, :completed_at, :datetime
  end
end
