class AddDeadlineAtToGoals < ActiveRecord::Migration[7.2]
  def change
    add_column :goals, :deadline_at, :datetime
  end
end
