class AddUserReferenceToRelationships < ActiveRecord::Migration[7.2]
  def change
    add_reference :event_relationships, :user, foreign_key: true, type: :uuid
  end
end
