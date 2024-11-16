class CreateWorkLoad < ActiveRecord::Migration[7.2]
  def change
    create_table :work_loads, id: :uuid do |t|
      t.references :work, type: :uuid, null: false, foreign_key: true
      t.integer :value, null: false
      t.timestamps
    end
  end
end
