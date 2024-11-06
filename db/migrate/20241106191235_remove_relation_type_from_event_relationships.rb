class RemoveRelationTypeFromEventRelationships < ActiveRecord::Migration[7.2]
  def change
    remove_column :event_relationships, :relation_type
  end
end
