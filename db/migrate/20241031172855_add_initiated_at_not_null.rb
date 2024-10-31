class AddInitiatedAtNotNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :activities, :initiated_at, false
    change_column_null :wishes, :initiated_at, false
    change_column_null :tasks, :initiated_at, false
    change_column_null :goals, :initiated_at, false
    change_column_null :interests, :initiated_at, false
    change_column_null :hobbies, :initiated_at, false
    change_column_null :vacations, :initiated_at, false
    change_column_null :travels, :initiated_at, false
    change_column_null :thoughts, :initiated_at, false
    change_column_null :actions, :initiated_at, false
    change_column_null :decisions, :initiated_at, false
  end
end
