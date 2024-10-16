class CreateRepeats < ActiveRecord::Migration[7.2]
  def change
    create_table :repeats, id: :uuid do |t|
      t.references :action, type: :uuid, null: false, foreign_key: true, index: true
      t.interval :duration
      t.text :details
      t.timestamps
    end
  end
end
