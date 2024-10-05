class CreateEventRelationships < ActiveRecord::Migration[7.2]
  def change
    create_table :event_relationships, id: :uuid do |t|
      t.references :triggerable, type: :uuid, polymorphic: true
      t.references :impactable, type: :uuid, polymorphic: true
      t.string :relation_type, null: false
      t.timestamps
    end
  end
end
