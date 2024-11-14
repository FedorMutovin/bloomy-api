class RemoveUnusedFieldsFromActions < ActiveRecord::Migration[7.2]
  def change
     remove_column :actions, :completed
     remove_column :actions, :completed_at
     remove_column :actions, :recurring
  end
end
