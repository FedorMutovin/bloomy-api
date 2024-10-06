class AddForeignKeyTasksActions < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :actions, :tasks, validate: false
  end
end
