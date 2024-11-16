class ChangeNullForReason < ActiveRecord::Migration[7.2]
  def change
    change_column_null :work_load_changes,  :reason, false
  end
end
