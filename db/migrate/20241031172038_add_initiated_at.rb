class AddInitiatedAt < ActiveRecord::Migration[7.2]
  def change
    add_column :activities, :initiated_at, :datetime
    add_column :wishes, :initiated_at, :datetime
    add_column :tasks, :initiated_at, :datetime
    add_column :goals, :initiated_at, :datetime
    add_column :interests, :initiated_at, :datetime
    add_column :hobbies, :initiated_at, :datetime
    add_column :vacations, :initiated_at, :datetime
    add_column :travels, :initiated_at, :datetime
    add_column :thoughts, :initiated_at, :datetime
    add_column :actions, :initiated_at, :datetime
    add_column :decisions, :initiated_at, :datetime
  end
end
