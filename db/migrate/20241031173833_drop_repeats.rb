class DropRepeats < ActiveRecord::Migration[7.2]
  def change
    drop_table :repeats
  end
end
