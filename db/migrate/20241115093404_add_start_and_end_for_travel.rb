class AddStartAndEndForTravel < ActiveRecord::Migration[7.2]
  def change
    add_column :travels, :start_at, :datetime, null: false
    add_column :travels, :end_at, :datetime, null: false
  end
end
