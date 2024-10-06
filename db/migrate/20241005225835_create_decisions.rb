class CreateDecisions < ActiveRecord::Migration[7.2]
  def change
    create_table :decisions, id: :uuid do |t|
      t.string :title, null: false
      t.text :reason
      t.timestamps
    end
  end
end
