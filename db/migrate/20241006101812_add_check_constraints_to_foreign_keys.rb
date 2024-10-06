class AddCheckConstraintsToForeignKeys < ActiveRecord::Migration[7.2]
  def change
    add_check_constraint :actions, "user_id IS NOT NULL", name: "actions_user_id_null", validate: false
    add_check_constraint :decisions, "user_id IS NOT NULL", name: "decisions_user_id_null", validate: false
    add_check_constraint :event_relationships, "triggerable_id IS NOT NULL", name: "event_relationships_triggerable_id_null", validate: false
    add_check_constraint :event_relationships, "triggerable_type IS NOT NULL", name: "event_relationships_triggerable_type_null", validate: false
    add_check_constraint :event_relationships, "impactable_id IS NOT NULL", name: "event_relationships_impactable_id_null", validate: false
    add_check_constraint :event_relationships, "impactable_type IS NOT NULL", name: "event_relationships_impactable_type_null", validate: false
    add_check_constraint :hobbies, "user_id IS NOT NULL", name: "hobbies_user_id_null", validate: false
  end
end