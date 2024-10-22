class AddStatusToGoal < ActiveRecord::Migration[7.2]
  def change
    add_column :goals, :status, :string, null: false, default: "pending"
  end
end
