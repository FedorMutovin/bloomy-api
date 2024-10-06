class ValidateForeignKeyTasksActions < ActiveRecord::Migration[7.2]
  def change
    validate_foreign_key :actions, :tasks
  end
end
