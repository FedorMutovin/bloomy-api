class CreateActions < ActiveRecord::Migration[7.2]
  def change
    create_table :actions, id: :uuid do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :completed, null: false, default: false
      t.datetime :completed_at
      t.boolean :recurring, null: false, default: false
      t.timestamps
    end
  end
end
