class AddNameColumn < ActiveRecord::Migration[7.2]
  def change
    add_column :wishes, :name, :string
    add_column :decisions, :name, :string
    add_column :actions, :name, :string
  end
end
