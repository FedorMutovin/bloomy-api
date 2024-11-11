class AddTimezoneToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :timezone, :string, null: true, default: "UTC"
  end
end
