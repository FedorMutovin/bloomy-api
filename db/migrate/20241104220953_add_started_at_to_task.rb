class AddStartedAtToTask < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :started_at, :datetime
  end
end
