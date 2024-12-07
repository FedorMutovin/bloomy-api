class AddNotNullToRelationshipUserId < ActiveRecord::Migration[7.2]
  def change
    change_column_null :event_relationships,  :user_id, false
  end
end
