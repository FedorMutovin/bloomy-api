class CreateWork < ActiveRecord::Migration[7.2]
  def change
    create_table :works, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :company_name, null: false
      t.string :position_name, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.timestamps
    end
  end
end
