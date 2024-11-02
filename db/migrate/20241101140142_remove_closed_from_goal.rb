class RemoveClosedFromGoal < ActiveRecord::Migration[7.2]
  def change
    remove_column :goals, :closed, :boolean
  end
end
