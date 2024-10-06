class CreateEventReflections < ActiveRecord::Migration[7.2]
  def change
    create_table :event_reflections, id: :uuid do |t|
      t.references :reflectable, type: :uuid, null: false, polymorphic: true
      t.text :description, null: false
      t.timestamps
    end
  end
end
