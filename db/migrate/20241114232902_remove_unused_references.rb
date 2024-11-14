class RemoveUnusedReferences < ActiveRecord::Migration[7.2]
  def change
    remove_reference :actions, :task
    remove_reference :actions, :goal
    remove_reference :tasks, :goal
  end
end
