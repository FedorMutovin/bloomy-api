class CreateActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :activities, id: :uuid do |t|
      t.references :user, foreign_key: true, null: false, type: :uuid
      t.string :name, null: false
      t.timestamps
    end
  end
end
