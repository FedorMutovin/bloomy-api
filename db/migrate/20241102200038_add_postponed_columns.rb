class AddPostponedColumns < ActiveRecord::Migration[7.2]
  def change
    add_column :goals, :postponed_at, :datetime
    add_column :goals, :postponed_until, :datetime
    add_column :tasks, :postponed_at, :datetime
    add_column :tasks, :postponed_until, :datetime
  end
end
