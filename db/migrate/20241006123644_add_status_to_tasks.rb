class AddStatusToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :status, :string, null: false, default: "pending"
  end
end