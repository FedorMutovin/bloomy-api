class CreateHobbies < ActiveRecord::Migration[7.2]
  def change
    create_table :hobbies, id: :uuid do |t|
      t.string :name, null: false
      t.integer :skill_level, null: false, default: 0
      t.timestamps
    end
  end
end
