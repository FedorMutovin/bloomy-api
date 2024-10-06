class RemoveUnusedFieldsFromActions < ActiveRecord::Migration[7.2]
  def change
    safety_assured { remove_column :actions, :completed }
    safety_assured { remove_column :actions, :completed_at }
    safety_assured { remove_column :actions, :recurring }
  end
end
