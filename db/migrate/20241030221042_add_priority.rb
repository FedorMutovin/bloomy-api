class AddPriority < ActiveRecord::Migration[7.2]
  def change
    add_column :goals, :priority, :integer, default: 0
    add_column :tasks, :priority, :integer, default: 0
    add_column :wishes, :priority, :integer, default: 0
  end
end
