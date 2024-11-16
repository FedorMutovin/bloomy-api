class AddReasonToWorkLoadChanges < ActiveRecord::Migration[7.2]
  def change
    add_column :work_load_changes,  :reason, :text
  end
end
