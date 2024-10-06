class AddReferenceTasksActions < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def change
    add_reference :actions, :task, type: :uuid, index: {algorithm: :concurrently}
  end
end
