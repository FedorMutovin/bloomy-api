class UpdateDecisions < ActiveRecord::Migration[7.2]
  def change
    remove_column :decisions, :reason, :string
    add_column :decisions, :description, :text
  end
end
