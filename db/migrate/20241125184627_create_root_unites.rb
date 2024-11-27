class CreateRootUnites < ActiveRecord::Migration[7.2]
  def change
    create_table :root_unites, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :source, type: :uuid, null: false, polymorphic: true
      t.references :target, type: :uuid, null: false, polymorphic: true
      t.text :reason, null: false
      t.timestamps
    end
  end
end
