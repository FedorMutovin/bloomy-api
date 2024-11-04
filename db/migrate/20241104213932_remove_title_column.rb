class RemoveTitleColumn < ActiveRecord::Migration[7.2]
  def change
    remove_column :wishes, :title, :string
    remove_column :decisions, :title, :string
    remove_column :actions, :title, :string
  end
end
