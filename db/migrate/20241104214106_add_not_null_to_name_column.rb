class AddNotNullToNameColumn < ActiveRecord::Migration[7.2]
  def change
    change_column_null :wishes, :name, false
    change_column_null :decisions, :name, false
    change_column_null :actions, :name, false
  end
end
