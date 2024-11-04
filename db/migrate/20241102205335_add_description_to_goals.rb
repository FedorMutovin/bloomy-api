class AddDescriptionToGoals < ActiveRecord::Migration[7.2]
  def change
    add_column :goals, :description, :text
  end
end
